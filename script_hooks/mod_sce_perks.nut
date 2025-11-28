::Const.Strings.PerkDescription.Duelist = "Become one with your weapon and go for the weak spots! With the offhand free or carrying a throwable tool (e.g. throwing net), an additional [color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] of any damage inflicted by one-handed weapons ignores armor.\n\nMelee attacks grant the 'Flowing Strikes' status, which refunds Fatigue on subsequent attacks.";
local perk = ::Const.Perks.Perks[6][1];
if (perk.ID == "perk.duelist")
	perk.Tooltip = ::Const.Strings.PerkDescription.Duelist;

::mods_hookExactClass("skills/perks/perk_duelist", function(pd) {
	::mods_addField(pd, "perk_duelist", "SkillCount", 0);

	local onTargetHit = ::mods_getMember(pd, "onTargetHit");
	local onTargetMissed = ::mods_getMember(pd, "onTargetMissed");
	local onCombatStarted = ::mods_getMember(pd, "onCombatStarted");
	local onCombatFinished = ::mods_getMember(pd, "onCombatFinished");

	::mods_override(pd, "onTargetHit", function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);

		local actor = getContainer().getActor();

		if (Tactical.TurnSequenceBar.getActiveEntity() == null || Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
			return;

		if (m.SkillCount == Const.SkillCounter)
			return;

		m.SkillCount = Const.SkillCounter;

		Time.scheduleEvent(TimeUnit.Virtual, 310, onAttackCallback, { Actor = actor, Skill = _skill });
	});

	::mods_override(pd, "onTargetMissed", function(_skill, _targetEntity) {
		onTargetMissed(_skill, _targetEntity);

		local actor = getContainer().getActor();

		if (Tactical.TurnSequenceBar.getActiveEntity() == null || Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
			return;

		if (m.SkillCount == Const.SkillCounter)
			return;

		m.SkillCount = Const.SkillCounter;

		Time.scheduleEvent(TimeUnit.Virtual, 310, onAttackCallback, { Actor = actor, Skill = _skill });
	});

	::mods_addMember(pd, "perk_duelist", "onAttackCallback", function(_tag) {
		if (_tag.Actor.isAlive() && Tactical.TurnSequenceBar.getActiveEntity().getID() == _tag.Actor.getID() && _tag.Skill.isAttack() && !(_tag.Skill.isRanged() || _tag.Skill.isOffensiveToolSkill())) {
			_tag.Actor.getSkills().add(new("scripts/skills/effects/flowing_strikes_effect"));
			_tag.Actor.setDirty(true);
		}
	});

	::mods_override(pd, "onCombatStarted", function() {
		m.SkillCount = 0;
	});

	::mods_override(pd, "onCombatFinished", function() {
		m.SkillCount = 0;
	});
});

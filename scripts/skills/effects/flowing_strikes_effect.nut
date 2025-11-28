flowing_strikes_effect <- inherit("scripts/skills/skill", {
	m = {
		Count			= 1
		CurrentTile		= null
		FatigueRefund	= 2
	}

	function create() {
		m.ID					= "effects.flowing_strikes";
		m.Name					= "Flowing Strikes";
		m.Icon					= "skills/status_effect_sce_01.png";
		m.IconMini				= "status_effect_sce_01_mini";
		m.Overlay				= "status_effect_sce_01";
		m.Type					= Const.SkillType.StatusEffect;
		m.IsActive				= false;
		m.IsStacking			= false;
		m.IsRemovedAfterBattle	= true;
	}

	function getName() {
		if (m.Count <= 1)
			return m.Name;
		else
			return m.Name + " (x" + m.Count + ")";
	}

	function getDescription() {
		return "This character's strikes flow from one to the next, refunding [color=" + Const.UI.Color.PositiveValue + "]" + m.FatigueRefund * m.Count + "[/color] Fatigue after each melee attack. Removed at the end of the round, on movement, or when the character uses a skill other than a melee attack.";
	}

	function getTooltip() {
		return [
					{ id = 1, type = "title", text = getName() }
					{ id = 2, type = "description", text = getDescription() }
				];
	}

	function onAdded() {
		m.CurrentTile = getContainer().getActor().getTile();
	}

	function onRefresh() {
		++m.Count;
	}

	function onMovementFinished() {
		if (m.CurrentTile != null && m.CurrentTile.ID != getContainer().getActor().getTile().ID)
			removeSelf();
	}

	function onResumeTurn() {
		if (m.CurrentTile != null && m.CurrentTile.ID != getContainer().getActor().getTile().ID)
			removeSelf();
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (!_skill.isAttack() || _skill.isRanged() || (_skill.isAttack() && _skill.m.IsOffensiveToolSkill))
			return removeSelf();
	}

	function onTargetMissed(_skill, _targetEntity) {
		getContainer().getActor().setFatigue(getContainer().getActor().getFatigue() - (m.FatigueRefund * m.Count));
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		getContainer().getActor().setFatigue(getContainer().getActor().getFatigue() - (m.FatigueRefund * m.Count));
	}

	function onRoundEnd() {
		removeSelf();
	}
});

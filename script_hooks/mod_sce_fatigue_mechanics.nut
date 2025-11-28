local perk = ::Const.Perks.Perks[0][7];
if (perk.ID == "perk.recover")
	perk.Tooltip = perk.Tooltip + "\n\nThe skill additionally removes all accumulated exertion.";


::mods_hookBaseClass("entity/tactical/actor", function(a) {
	local onAfterInit = ::mods_getMember(a, "onAfterInit");
	local onTurnStart = ::mods_getMember(a, "onTurnStart");

	::mods_override(a, "onAfterInit", function() {
		onAfterInit();

		// Add exertion to any actor capable of building up Fatigue
		if (m.CurrentProperties.FatigueEffectMult > 0.0)
			m.Skills.add(new("scripts/skills/special/exertion"));
	});

	::mods_override(a, "onTurnStart", function() {
		local turnStartFatigue = getFatigue();
		local turnStartProperties = m.CurrentProperties;
		local stammedOut = turnStartFatigue == getFatigueMax();

		onTurnStart();

		if (stammedOut)
			setFatigue(Math.max(0, Math.min(turnStartFatigue - ::SCE.MinimumFatigueRecoveryRate, turnStartFatigue - turnStartProperties.FatigueRecoveryRate) * turnStartProperties.FatigueRecoveryRateMult));
	});
});

::mods_hookExactClass("skills/actives/recover_skill", function(rs) {
	local getTooltip = ::mods_getMember(rs, "getTooltip");
	local onUse = ::mods_getMember(rs, "onUse");

	::mods_override(rs, "getTooltip", function() {
		local ret = getTooltip();

		ret.push({ id = 7, type = "text", icon = "ui/icons/special.png", text = "Removes all accumulated exertion" });

		return ret;
	});

	::mods_override(rs, "onUse", function(_user, _targetTile) {
		onUse(_user, _targetTile);

		local exertion = _user.getSkills().getSkillByID("effects.exertion");
		if (exertion != null)
			exertion.setCount
	});
});

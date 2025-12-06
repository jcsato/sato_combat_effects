::mods_hookExactClass("items/shields/shield", function(s) {
	local applyShieldDamage = ::mods_getMember(s, "applyShieldDamage");

	::mods_override(s, "applyShieldDamage", function(_damage, _playHitSound = true) {
		// Save reference to actor prior to running `applyShieldDamage`, as that `drop`s the shield on destruction
		local actor = getContainer().getActor();
		applyShieldDamage(_damage, _playHitSound);

		if (getCondition() == 0)
			actor.getSkills().add(new("scripts/skills/effects/off_balance_effect"));
	});
});

::mods_hookExactClass("skills/special/double_grip", function(dg) {
	local canDoubleGrip = ::mods_getMember(dg, "canDoubleGrip");

	::mods_override(dg, "canDoubleGrip", function() {
		if (getContainer().getActor().getSkills().hasSkill("effects.off_balance"))
			return false;
		else
			return canDoubleGrip();
	})
});

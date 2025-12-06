::mods_registerMod("sato_combat_effects", 0.3, "Sato's Combat Effects");

::mods_queue("sato_combat_effects", ">sato_balance_mod", function() {
	::include("script_hooks/!sce_constants");
	::include("script_hooks/mod_sce_fatigue_mechanics");
	::include("script_hooks/mod_sce_perks");
	::include("script_hooks/mod_sce_recovery_items");
	::include("script_hooks/mod_sce_shields");
	::include("script_hooks/mod_sce_tryout");
});

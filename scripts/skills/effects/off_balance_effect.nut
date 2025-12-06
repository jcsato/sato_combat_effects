off_balance_effect <- inherit("scripts/skills/skill", {
	m = {
		APMalus			= 2
		TurnsLeft		= 1
	}

	function create() {
		m.ID					= "effects.off_balance";
		m.Name					= "Off Balance";
		m.Icon					= "skills/status_effect_sce_02.png";
		m.IconMini				= "status_effect_sce_02_mini";
		m.Overlay				= "status_effect_sce_02";
		m.Type					= Const.SkillType.StatusEffect;
		m.IsActive				= false;
		m.IsStacking			= false;
		m.IsRemovedAfterBattle	= true;
	}

	function getDescription() {
		return "This character's shield was destroyed and the impact has left them reeling and off balance for [color=" + Const.UI.Color.NegativeValue + "]" + m.TurnsLeft + "[/color] more turn(s).";
	}

	function getTooltip() {
		return [
					{ id = 1, type = "title", text = getName() }
					{ id = 2, type = "description", text = getDescription() }
					{ id = 10, type = "text", icon = "ui/icons/action_points.png", text = "[color=" + Const.UI.Color.NegativeValue + "]-" + m.APMalus + "[/color] Action Points" }
					{ id = 11, type = "text", icon = "ui/icons/special.png", text = "Cannot benefit from Double Grip" }
				];
	}

	function onAdded() {
		local actor = getContainer().getActor();

		if (actor.getCurrentProperties().IsResistantToAnyStatuses && Math.rand(1, 100) <= 50) {
			if (!actor.isHiddenToPlayer())
				Tactical.EventLog.log(Const.UI.getColorizedEntityName(actor) + " quickly regained balance thanks to his unnatural physiology");

			removeSelf();
		} else {
			setTurns(Math.max(1, 1 + getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration))
		}
	}

	function onRefresh() {
		setTurns(Math.max(1, 1 + getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration))
	}

	function onTurnEnd() {
		if (getTurns() <= 1)
			removeSelf();
		else
			addTurns(-1);
	}

	function addTurns( _t ) {
		m.TurnsLeft += _t;
	}

	function setTurns( _t ) {
		if (getContainer() != null)
			m.TurnsLeft = Math.max(1, _t + getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function getTurns() {
		return m.TurnsLeft;
	}

	function onUpdate(_properties) {
		_properties.ActionPoints	-= m.APMalus;
	}
});

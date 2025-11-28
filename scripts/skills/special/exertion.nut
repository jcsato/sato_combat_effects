exertion <- inherit("scripts/skills/skill", {
	m = {
		Count					= 0
		FatigueRecoveryMalus	= 1
		MaxCount				= 5
	}

	function create() {
		m.ID					= "special.exertion";
		m.Name					= "Exertion";
		m.Icon					= "ui/perks/perk_18.png";
		m.IconMini				= "perk_18_mini";
		m.Overlay				= "perk_18";
		m.Type					= Const.SkillType.Special | Const.SkillType.StatusEffect;
		m.Order					= Const.SkillOrder.Last;
		m.IsActive				= false;
		m.IsHidden				= true;
		m.IsSerialized			= false;
	}

	function getName() {
		if (m.Count <= 1)
			return m.Name;
		else
			return m.Name + " (x" + m.Count + ")";
	}

	function getDescription() {
		return "This character is over-exerting themselves and cannot recover Fatigue effectively.";
	}

	function getTooltip() {
		local ret = [
			{ id = 1, type = "title", text = getName() }
			{ id = 2, type = "description", text = getDescription() }
			{ id = 11, type = "text", icon = "ui/icons/fatigue.png", text = "[color=" + Const.UI.Color.NegativeValue + "]-" + m.FatigueRecoveryMalus * m.Count + "[/color] Fatigue Recovery per turn" }
			{ id = 12, type = "text", icon = "ui/icons/special.png", text = "[color=" + Const.UI.Color.NegativeValue + "]1[/color] stack added when ending a turn with less than 10 available Fatigue" }
			{ id = 13, type = "text", icon = "ui/icons/special.png", text = "[color=" + Const.UI.Color.PositiveValue + "]1[/color] stack removed for every 10 available Fatigue when ending a turn" }
			{ id = 13, type = "text", icon = "ui/icons/special.png", text = "Stacks up to [color=" + Const.UI.Color.NegativeValue + "]" + m.MaxCount + "[/color] times" }
		];

		return ret;
	}

	function setCount(_c) {
		m.Count = Math.min(0, _c);
	}

	function onCombatFinished() {
		m.Count = 0;
	}

	function onTurnEnd() {
		local actor = getContainer().getActor();
		local availableFatigue = actor.getFatigueMax() - actor.getFatigue();

		if (availableFatigue < 10) {
			if (m.Count < m.MaxCount)
				spawnIcon("perk_18", actor.getTile());

			m.Count = Math.min(m.MaxCount, m.Count + 1);
		} else {
			m.Count = Math.max(0, m.Count - Math.floor(availableFatigue / 10));
		}
	}

	function onUpdate(_properties) {
		if (m.Count > 0) {
			m.IsHidden = false;
			_properties.FatigueRecoveryRate -= m.FatigueRecoveryMalus * m.Count;
		} else {
			m.IsHidden = true;
		}
	}
});

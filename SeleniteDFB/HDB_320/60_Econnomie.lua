-- Energy saving
local function energy()
	local self = {}

	cdt = MQTTCounterStat('Stat mensuelle', 'Domestik/Electricite/Mensuel')

	return self
end

Energy = energy()

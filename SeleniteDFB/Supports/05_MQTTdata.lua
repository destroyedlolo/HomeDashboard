-- Generic class to handle MQTT stuffs

function MQTTdata( name, tpc )
	local self = {}

	-- methods
	function self.getName()
		return name
	end

	function self.getTopic()
		return topic
	end

	return self
end

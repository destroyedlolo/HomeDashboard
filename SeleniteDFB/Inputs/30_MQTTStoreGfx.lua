-- Receive an MQTT data and trace it

function MQTTStoreGfx(
	name, topic,
	func,	-- validation function
	sval,	-- surface to display the value
	sgfx,	-- surface to display the graphic
	smin	-- surface to display the miminum
)
	local self = MQTTinput( name, topic, func )

	return self
end

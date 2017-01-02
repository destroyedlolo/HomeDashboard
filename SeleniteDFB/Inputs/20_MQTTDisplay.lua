-- Receive an MQTT data and display it

function MQTTDisplay(
	name, topic,
	func,	-- validation function
	sval,	-- surface to display the value
	suffix	-- string to add to the value (i.e. : unit)
)
	local self = MQTTinput( name, topic, func )

	function self.update()
		local v = self.get()

		if suffix then
			v = v .. suffix
		end
print( v )
	end

	-- init
	self.TaskAdd( self.update )

	return self
end

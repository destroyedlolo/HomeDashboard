-- Receive an MQTT data and display it

function MQTTDisplay(
	name, topic,
	func,	-- validation function
	srf,	-- surface to display the value
	suffix,	-- string to add to the value (i.e. : unit)
	gradient	-- gradient to colorize 
)
	local self = MQTTinput( name, topic, func )

	function self.update()
		local v = self.get()

		if gradient then
			srf.get():SetColor( gradient.findgradientcolor(v) )
		end

		if suffix then
			v = v .. suffix
		end
		
		srf.update(v)
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self
end

-- Receive an MQTT data and display it

function MQTTDisplay(
	name, topic,
	srf,	-- surface to display the value
	opts
)
--[[ known options  :
--	vfunction : validation function
--	suffix : string to add to the value (i.e. : unit)
--]]
	if not opts then
		opts = {}
	end

	local self = MQTTinput( name, topic, opts.vfunction)

	function self.update()
		local v = self.get()

		if gradient then
			srf.setColorRGB( gradient.findgradientcolor(v) )
		end

		if opts.suffix then
			v = v .. opts.suffix
		end
		
		srf.update(v)
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self
end

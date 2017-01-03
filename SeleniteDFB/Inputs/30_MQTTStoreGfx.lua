-- Receive an MQTT data and trace it

function MQTTStoreGfx(
	name, topic,
	srf,	-- surface to display the value
	suffix,	-- string to add to the value (i.e. : unit)
	gradient,	-- gradient to colorize 
	sgfx,	-- surface to display the graphic
	smin,	-- surface to display the miminum
	forced_min
)
	local dt = SelCollection.create( sgfx.get():GetWidth() )

	local function adddt( t, v )
		SelShared.set( t, v )
		dt:Push(v)
		return true
	end

	local self = MQTTDisplay( name, topic, adddt, srf, suffix, gradient )

	local function updgfx()
print("updgfx")
dt:dump()
		sgfx.DrawGfx(dt, forced_min)
	end

	self.TaskOnceAdd( updgfx )

	return self
end

-- Receive an MQTT data and trace it

function MQTTStoreGfx(
	name, topic,
	srf,	-- surface to display the value
	suffix,	-- string to add to the value (i.e. : unit)
	gradient,	-- gradient to colorize 
	sgfx,	-- surface to display the graphic
	smax,	-- surface to display the miminum
	forced_min
)
	local dt = SelCollection.create( sgfx.get():GetWidth() )

	local function adddt( )
		local v = SelShared.get( topic )
		dt:Push(v)
	end

	local self = MQTTDisplay( name, topic, nil, srf, suffix, gradient )

	local function updgfx()
		sgfx.DrawGfx(dt, forced_min)
		SelShared.PushTask( sgfx.refresh, SelShared.TaskOnceConst("LAST") )
	end

	local function updmin()
		local _,max = dt:MinMax()
		smax.update( max )
	end

	self.TaskOnceAdd( adddt )
	self.TaskOnceAdd( updgfx )
	self.TaskOnceAdd( updmin )

	return self
end

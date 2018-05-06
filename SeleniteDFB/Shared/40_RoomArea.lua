-- Extended information for bedrooms

function RoomArea(
	srf,			-- parent surface
	name, topic,
	x,y,			-- top left of this area
	topic_mode,		-- mode's topic
	topic_hlever,	-- wakeup's topic
	opts
)
--[[ known options  :
--]]
	self = MinorTempArea( srf, name, topic, x,y, opts )

	local offx,offy = self.getBelow()
	local srf_mode = FieldBlink( srf, animTimer, offx,offy,  fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER, width = self.getSize()
	})
	MQTTDisplay( topic_mode, topic_mode, srf_mode )


	local function format_time( t, m )
		SelShared.Set(t, string.gsub(m, '%.',':'))
		return true
	end

	local offx,offy = srf_mode.get():GetBelow()
	local srf_hlever = FieldBlink( srf, animTimer, offx,offy,  fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER, width = self.getSize()
	})
	MQTTDisplay( topic_hlever, topic_hlever, srf_hlever, {
		vfunction = format_time
	})

	return self
end

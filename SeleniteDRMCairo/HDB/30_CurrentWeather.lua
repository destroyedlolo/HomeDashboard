-- Display current weather conditions

function cweather(
	psrf,	-- parent surface
	x,y,	-- top left of this area
	opts
)
--[[ known options  :
--]]

	if not opts then
		opts = {}
	end

	local self = SubSurface( psrf, x,y, 300, 170 )

	local name
	function self.setName( tp )
		name = tp
	end

	local icon = ImageSurface( self, 0,0, 160, 120, { transparency = true } )
	self.desc = FieldBlink( self, animTimer, 0, 135, fonts.sdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		width = 160
	} )

	function self.updTime()
		local t=os.date("*t", tonumber(SelShared.Get(name)) )
		time.update(string.format("%02d:%02d", t.hour, t.min))
	end

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelShared.Get(name..'acode') ) )
	end

	return self
end

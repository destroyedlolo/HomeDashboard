-- Display short term weather forcast

function stweather(
	psrf,	-- parent surface
	x,y,	-- top left of this area
	opts
)
--[[ known options  :
--]]
	if not opts then
		opts = {}
	end

	local self = {}
	local name
	function self.setName( tp )
		name = tp
	end

	local goffx = x
	local goffy = y

	function self.getWidth()
		return 35
	end

	function self.getNext()
		return self.getWidth() + x
	end

	local time = FieldBlink( psrf, animTimer, goffx, goffy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		width = self.getWidth()
	} )
	_, goffy = time.get():GetBelow()

	local icon = ImageSurface( psrf, goffx, goffy, 35, 24 )
	goffy = goffy + 24

	self.temp = Field( psrf, goffx, goffy,
		fsdigit, COL_DIGIT, {
			suffix = '°C',
			align = ALIGN_CENTER,
			ndecimal = 1,
			width = self.getWidth()
		}
	)

	function self.updTime()
		local t=os.date("*t", tonumber(SelShared.get(name)) )
		time.update(string.format("%02d:%02d", t.hour, t.min))
	end

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelShared.get(name..'acode') ) )
	end

	return self
end

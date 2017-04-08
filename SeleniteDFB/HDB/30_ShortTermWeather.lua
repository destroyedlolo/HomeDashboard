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
		return 100
	end

	function self.getNext()
		return self.getWidth() + x
	end

	local time = Field( psrf, goffx, goffy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		width = self.getWidth() - 15
	} )
	goffx, goffy = time.get():GetBellow()

	local icon = ImageSurface( psrf, goffx, goffy, 78, 54 )
	goffy = goffy + 54

	self.temp = Field( psrf, goffx, goffy,
		fsdigit, COL_DIGIT, {
			suffix = '°C',
			align = ALIGN_CENTER,
			ndecimal = 1,
			width = 78
		}
	)
	goffx, goffy = self.temp.get():GetBellow()

	self.windspeed = Field( psrf, goffx, goffy,
		fsdigit, COL_DIGIT, {
			align = ALIGN_RIGHT,
			width = 78 - fsdigit:GetHeight()
		}
	)
	goffx, goffy = self.windspeed.get():GetAfter()
	self.windd = WindDir( psrf, goffx, goffy, fsdigit:GetHeight(), fsdigit:GetHeight())
	goffx, goffy = self.windspeed.get():GetBellow()

	self.clouds = Field( psrf, goffx, goffy,
		fsdigit, COL_DIGIT, {
			suffix = '%',
			align = ALIGN_RIGHT,
			width = 78 - fsdigit:GetHeight()
		}
	)
	goffx, goffy = self.clouds.get():GetAfter()
	WeatherIcons.getImg( '21' ):RenderTo( psrf, { goffx, goffy, fsdigit:GetHeight(), fsdigit:GetHeight() } )

	function self.updTime()
		local t=os.date("*t", tonumber(SelShared.get(name)) )
		time.update(string.format("%02d:%02d", t.hour, t.min))
	end

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelShared.get(name..'acode') ) )
	end

	return self
end

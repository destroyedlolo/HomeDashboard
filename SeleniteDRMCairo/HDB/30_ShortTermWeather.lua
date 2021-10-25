-- Display 3H weather forcast

function ShortTermWeather(
	psrf,	-- parent surface
	x,y,	-- top left of this area
	opts
)
--[[ known options  :
--]]
	if not opts then
		opts = {}
	end

	local self = SubSurface( psrf, x,y, 100, 160 )

	local name
	function self.setName( tp )
		name = tp
	end

	local time = Field( self, 0, 0, fonts.sdigit, COL_DIGIT, {
		bgcolor = false,
		transparency = true,
		align = ALIGN_CENTER,
		width = self.get():GetWidth()
	} )
	local goffx, goffy = time.getBelow()

	local icon = ImageSurface( 
		self, goffx+5, goffy, 78, 56, {
			transparency = true,
			autoscale = true
		}
	)
	goffy = goffy + 56

	self.temp = Field( self, goffx, goffy,
		fonts.sdigit, COL_DIGIT, {
			gradient = GRD_TEMPERATURE,
			bgcolor = false,
			transparency = true,
			suffix = '°C',
			align = ALIGN_CENTER,
			ndecimal = 1,
			width = self.get():GetWidth()
		}
	)
	goffx, goffy = self.temp.getBelow()

	self.windspeed = Field( self, goffx, goffy,
		fonts.sdigit, COL_DIGIT, {
			bgcolor = false,
			transparency = true,
			align = ALIGN_RIGHT,
			width = self.get():GetWidth() - fonts.sdigit.size
		}
	)
	goffx, goffy = self.windspeed.getAfter()
	self.windd = WindDir( self, 
		goffx, goffy, fonts.sdigit.size, fonts.sdigit.size, 
		{
			bgcolor = false,
		}
	)
	goffx, goffy = self.windspeed.getBelow()

	self.clouds = Field( self, goffx, goffy,
		fonts.sdigit, COL_DIGIT, {
			bgcolor = false,
			transparency = true,
			suffix = '%',
			align = ALIGN_RIGHT,
			width = self.get():GetWidth() - fonts.sdigit.size-10
		}
	)
	goffx, goffy = self.clouds.getAfter()
	local cloud = ImageSurface( self, goffx, goffy, fonts.smdigit.size+10, fonts.smdigit.size+10, { autoscale=true } )
	cloud.Update( WeatherIcons.getImg('21') )

	function self.updTime()
		local t=os.date("*t", tonumber(SelShared.Get(name)) )
		time.update(string.format("%02d:%02d", t.hour, t.min))
	end

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelShared.Get(name..'acode') ) )
	end

--	self.Refresh()
	return self
end

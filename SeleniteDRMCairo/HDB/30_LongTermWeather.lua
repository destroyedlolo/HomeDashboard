-- Display long term weather

function LongTermWeather(
	psrf,	-- parent surface
	x,y,	-- top left of this area
	opts
)
--[[ known options  :
--]]
	if not opts then
		opts = {}
	end

	local self = SubSurface( psrf, x,y, 100, 130 )

	local name
	function self.setName( tp )
		name = tp
	end

	local icon = ImageSurface( self, 
		15, 0, 70, 49, {
			transparency = true,
			autoscale = true
		}
	)
	local goffx, goffy = 0, 50

	local time = Field( self, goffx, goffy, fonts.sdigit, COL_DIGIT, {
		bgcolor = false,
		transparency = true,
		align = ALIGN_CENTER,
		width = self.get():GetWidth()
	} )
	local goffx, goffy = time.getBelow()

	self.tmax = Field( self, goffx, goffy, fonts.sdigit, COL_DIGIT, {
		bgcolor = false,
		transparency = true,
		suffix = '°C',
		ndecimal = 1,
		align = ALIGN_CENTER,
		width = self.get():GetWidth()
	} )
	goffx, goffy = self.tmax.getBelow()

	self.tmin = Field( self, goffx, goffy, fonts.sdigit, COL_DIGIT, {
		bgcolor = false,
		transparency = true,
		suffix = '°C',
		ndecimal = 1,
		align = ALIGN_CENTER,
		width = self.get():GetWidth()
	} )

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelShared.Get(name..'acode') ) )
	end

	function self.updTime()
		local wdays = {'Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'}

		local t=os.date("*t", tonumber(SelShared.Get(name)) )
		time.update(wdays[t.wday] ..' '.. t.day ..'/'.. t.month)
	end

	return self
end

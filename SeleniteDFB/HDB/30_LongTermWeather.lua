-- Display short term weather forcast

function ltweather(
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
		return 105
	end

	function self.getNext()
		return self.getWidth() + x
	end

	local icon = ImageSurface( psrf, goffx+5, goffy, 70, 49 )
	goffy = goffy + 49

	local time = Field( psrf, goffx, goffy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		width = self.getWidth() - 15
	} )
	goffx, goffy = time.get():GetBelow()

	self.tmax = Field( psrf, goffx, goffy, fsdigit, COL_DIGIT, {
		suffix = '°C',
		ndecimal = 1,
		align = ALIGN_CENTER,
		width = self.getWidth() - 15
	} )
	goffx, goffy = self.tmax.get():GetBelow()

	self.tmin = Field( psrf, goffx, goffy, fsdigit, COL_DIGIT, {
		suffix = '°C',
		align = ALIGN_CENTER,
		width = self.getWidth() - 15
	} )

	function self.getBelow()
		return self.tmin.get():GetBelow()
	end

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelShared.get(name..'acode') ) )
	end

	function self.updTime()
		local wdays = {'Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'}

		local t=os.date("*t", tonumber(SelShared.get(name)) )
		time.update(wdays[t.wday] ..' '.. t.day ..'/'.. t.month)
	end

	return self
end

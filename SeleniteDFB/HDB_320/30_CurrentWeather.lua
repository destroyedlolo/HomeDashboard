-- Display current weather condition

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

	local self = {}

	local name
	function self.setName( tp )
		name = tp
	end

	psrf:SetColor( COL_TITLE.get() )
	psrf:SetFont( ftitle1 )
	psrf:DrawString("Prévisions du jour", 0, 0)
	local goffy = y + ftitle1:GetHeight() + 15
	local goffx = x + 130

	local icon = ImageSurface( psrf, x, goffy, 110, 76 )
	self.desc = FieldBlink( psrf, animTimer, x, goffy + 76, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		width = 110
	} )

	psrf:SetFont( fsdigit )
	psrf:DrawString("Pour :", goffx, goffy)
	local time = FieldBlink( psrf,
		animTimer, goffx + fsdigit:StringWidth("Pour : "), goffy,
		fsdigit, COL_DIGIT, {
			align = ALIGN_CENTER,
			sample_text = "88:88"
		}
	)
	goffy = goffy + fsdigit:GetHeight()

	self.temp = FieldBlink( psrf,
		animTimer, goffx, goffy,
		fdigit, COL_DIGIT, {
			align = ALIGN_RIGHT,
			ndecimal = 1,
			sample_text = "-88:8"
		}
	)
	psrf:SetFont( fdigit )
	psrf:DrawString("°C", self.temp.get():GetAfter() )
	goffy = goffy + fdigit:GetHeight()
	psrf:SetFont( fsdigit )

	self.windd = WindDir( psrf, goffx, goffy, fsdigit:GetHeight(), fsdigit:GetHeight())
	self.windspeed = FieldBlink( psrf,
		animTimer, goffx + fsdigit:GetHeight(), goffy,
		fsdigit, COL_DIGIT, {
			align = ALIGN_RIGHT,
			sample_text = "88.88"
		}
	)
	psrf:DrawString(" km/h", goffx + fsdigit:GetHeight() + fsdigit:StringWidth("88.88"), goffy)
	goffy = goffy + fsdigit:GetHeight()

	WeatherIcons.getImg( '21' ):RenderTo( psrf, { goffx, goffy, fsdigit:GetHeight(), fsdigit:GetHeight() } )
	self.clouds = FieldBlink( psrf,
		animTimer, goffx + fsdigit:GetHeight(), goffy,
		fsdigit, COL_DIGIT, {
			suffix = '%',
			align = ALIGN_RIGHT,
			sample_text = "188%"
		}
	)
	goffy = goffy + fsdigit:GetHeight()

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .."/Images/Goutte.png")
	assert(img)
	img:RenderTo( psrf, { goffx, goffy, fsdigit:GetHeight(), fsdigit:GetHeight() } )
	img:destroy()

	self.humidity = FieldBlink( psrf,
		animTimer, goffx + fsdigit:GetHeight(), goffy,
		fsdigit, COL_DIGIT, {
			suffix = '%',
			align = ALIGN_RIGHT,
			sample_text = "188%"
		}
	)
	goffy = goffy + fsdigit:GetHeight()
	local _,t = self.desc.get():GetBellow()
	goffy = math.max( goffy, t )

	function self.getBellow()
		return goffy
	end

	function self.updTime()
		local t=os.date("*t", tonumber(SelShared.get(name)) )
		time.update(string.format("%02d:%02d", t.hour, t.min))
	end

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelShared.get(name..'acode') ) )
	end

	return self
end

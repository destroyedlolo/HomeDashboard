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
	psrf:SetFont( ftitle )
	psrf:DrawString("Prévisions du jour", 0, 0)

	local goffy = ftitle:GetHeight() + 10

	local icon = psrf:SubSurface( 0, goffy, 184, 128 )
	self.desc = FieldBlink( psrf, animTimer, 0, goffy + 129, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		width = 184
	} )

	psrf:SetFont( fsdigit )
	psrf:DrawString("Pour :", 190, goffy)
	local time = FieldBlink( psrf,
		animTimer, 190 + fsdigit:StringWidth("Pour : "), goffy,
		fsdigit, COL_DIGIT, {
			align = ALIGN_CENTER,
			sample_text = "88:88"
		}
	)
	goffy = goffy + fsdigit:GetHeight()

	self.temp = FieldBlink( psrf,
		animTimer, 190, goffy,
		fdigit, COL_DIGIT, {
			suffix = '°C',
			align = ALIGN_RIGHT,
			ndecimal = 1,
			sample_text = "-88:8°C"
		}
	)
	goffy = goffy + fdigit:GetHeight()

	self.windspeed = FieldBlink( psrf,
		animTimer, 190 + fsdigit:GetHeight(), goffy,
		fsdigit, COL_DIGIT, {
			align = ALIGN_RIGHT,
			sample_text = "88:88"
		}
	)
	psrf:DrawString(" km/h", 190 + fsdigit:GetHeight() + fsdigit:StringWidth("88:88"), goffy)

	function self.updtime()
		local t=os.date("*t", tonumber(SelShared.get(name)) )
		time.update(string.format("%02d:%02d", t.hour, t.min))
	end

	return self
end

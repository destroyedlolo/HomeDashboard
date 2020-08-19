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

	local self = SubSurface( psrf, x,y, 475, 170 )

	local name
	function self.setName( tp )
		name = tp
	end

	local icon = ImageSurface( 
		self, 0,0, 280, 194, { 
			transparency = true,
			autoscale = true
		} 
	)
	self.desc = FieldBlink( self, animTimer, 0, 194, fonts.sdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		width = 280
	} )

	self.setFont( fonts.smdigit )
	self.setColor( COL_TITLE )
	self.get():DrawStringTop("Pour :", 310,0)

	local time = FieldBlink( self,
		animTimer, 310 + self.get():GetStringExtents("Pour_:_"), 0,
		fonts.smdigit, COL_DIGIT, {
			align = ALIGN_CENTER,
			sample_text = "88:88"
		}
	)

	local offy = time.getHight()

	self.temp = FieldBlink( self,
		animTimer, 310, offy,
		fonts.digit, COL_DIGIT, {
			align = ALIGN_RIGHT,
			ndecimal = 1,
			sample_text = "-88:8"
		}
	)
	self.setFont( fonts.digit )
	self.get():DrawStringTop("°C", self.temp.getAfter())
	
	function self.updTime()
		local t=os.date("*t", tonumber(SelShared.Get(name)) )
		time.update(string.format("%02d:%02d", t.hour, t.min))
	end

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelShared.Get(name..'acode') ) )
	end

	self.Refresh()
	return self
end

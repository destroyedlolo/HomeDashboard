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

	local self = SubSurface( psrf, x,y, 500, 170 )

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

	local offy = 20
	self.setFont( fonts.smdigit )
	self.setColor( COL_TITLE )
	self.get():DrawStringTop("Pour :", 310,offy)

	local time = FieldBlink( self,
		animTimer, 310 + self.get():GetStringExtents("Pour_:_"), offy,
		fonts.smdigit, COL_DIGIT, {
			align = ALIGN_CENTER,
			sample_text = "88:88"
		}
	)

	offy = offy + time.getHight()

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
	offy = offy + self.temp.getHight()
	
	self.windd = WindDir( self, 310, offy, fonts.mdigit.size,fonts.mdigit.size)
	self.windspeed = FieldBlink( self,
		animTimer, 310 + fonts.mdigit.size, offy,
		fonts.mdigit, COL_DIGIT, {
			align = ALIGN_RIGHT,
			sample_text = "88.88"
		}
	)
	self.setFont( fonts.mdigit )
	self.get():DrawStringTop(" km/h", self.windspeed.getAfter())
	offy = offy + self.windspeed.getHight()

	local cloud = ImageSurface( self, 310, offy, fonts.mdigit.size+10, fonts.mdigit.size+10, { autoscale=true } )
	cloud.Update( WeatherIcons.getImg('21') )
	self.clouds = FieldBlink( self,
		animTimer, 320 + fonts.mdigit.size, offy,
		fonts.mdigit, COL_DIGIT, {
			suffix = '%',
			align = ALIGN_RIGHT,
			sample_text = "188%"
		}
	)
	offy = offy + self.clouds.getHight()

	local drop = ImageSurface( self, 310, offy, fonts.mdigit.size, fonts.mdigit.size, { autoscale=true } )
	drop.Update( DropImg )
	self.humidity = FieldBlink( self,
		animTimer, 320 + fonts.mdigit.size, offy,
		fonts.mdigit, COL_DIGIT, {
			suffix = '%',
			align = ALIGN_RIGHT,
			sample_text = "188%"
		}
	)
	offy = offy + self.humidity.getHight()

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

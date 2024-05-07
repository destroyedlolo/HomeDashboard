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

	local self = SubSurface( psrf, x,y, 433, 195 )

	local name
	function self.setName( tp )
		name = tp
	end

	local icon = ImageSurface( 
		self, 0,0, 250, 174, { 
			transparency = true,
			autoscale = true
		} 
	)
	self.desc = FieldBlink( self, animTimer, 0, 174, fonts.xsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		width = 280
	} )

	local offx,offy = 280,20
	self.setFont( fonts.sdigit )
	self.setColor( COL_TITLE )
	self.get():DrawStringTop("Pour :", offx,offy)

	local time = FieldBlink( self,
		animTimer, offx + self.get():GetStringExtents("Pour_:_"), offy,
		fonts.sdigit, COL_DIGIT, {
			align = ALIGN_CENTER,
			sample_text = "88:88"
		}
	)

	offy = offy + time.getHight()

	self.temp = FieldBlink( self,
		animTimer, offx, offy,
		fonts.mdigit, COL_DIGIT, {
			gradient = GRD_TEMPERATURE,
			align = ALIGN_RIGHT,
			ndecimal = 1,
			sample_text = "-88:8"
		}
	)
	self.setFont( fonts.mdigit )
	self.get():DrawStringTop("°C", self.temp.getAfter())
	offy = offy + self.temp.getHight()
	
	self.windd = WindDir( self, offx, offy, fonts.smdigit.size,fonts.smdigit.size)
	self.windspeed = FieldBlink( self,
		animTimer, offx + fonts.smdigit.size, offy,
		fonts.smdigit, COL_DIGIT, {
			align = ALIGN_RIGHT,
			sample_text = "88.88"
		}
	)
	self.setFont( fonts.smdigit )
	self.get():DrawStringTop(" km/h", self.windspeed.getAfter())
	offy = offy + self.windspeed.getHight()

	local cloud = ImageSurface( self, offx, offy, fonts.smdigit.size+10, fonts.smdigit.size+10, { autoscale=true } )
	cloud.Update( WeatherIcons.getImg('21') )
	self.clouds = FieldBlink( self,
		animTimer, offx + fonts.smdigit.size + 10, offy,
		fonts.smdigit, COL_DIGIT, {
			suffix = '%',
			align = ALIGN_RIGHT,
			sample_text = "188%"
		}
	)
	offy = offy + self.clouds.getHight()

	local drop = ImageSurface( self, offx, offy, fonts.smdigit.size, fonts.smdigit.size, { autoscale=true } )
	drop.Update( DropImg )
	self.humidity = FieldBlink( self,
		animTimer, offx + fonts.smdigit.size + 10, offy,
		fonts.smdigit, COL_DIGIT, {
			suffix = '%',
			align = ALIGN_RIGHT,
			sample_text = "188%"
		}
	)
	offy = offy + self.humidity.getHight()

	function self.updTime()
		local t=os.date("*t", tonumber(SelSharedVar.Get(name)) )
		time.update(string.format("%02d:%02d", t.hour, t.min))
	end

	function self.updateIcon()
		icon.Update( WeatherIcons.getImg( SelSharedVar.Get(name..'acode') ) )
	end

	self.Refresh()
	return self
end

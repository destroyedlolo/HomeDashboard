-- Weather forecast

local function meteo()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h, 
		{
			keepcontent = true
		}
	)

	----
	-- Additional graphics
	----

	local SunriseImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Sunrise.png")
	if not SunriseImg then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear(
		clipped -- Clipping region
	)
		-- Restrict drawing area
		if clipped then	-- Offset this surface
			self.get():SaveContext()
			self.get():SetClipS( unpack(clipped) )
		end
	
		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.setColor( COL_TITLE )
		self.setFont( fonts.title )
		self.get():DrawStringTop("Prévisions météo pour Nonglard", 5,0 )

		self.get():Blit(SunriseImg, 600,10)

		if clipped then
			self.get():RestoreContext()
		end
	end

	self.Clear()

	local srf_sunrise = FieldBlink( self, animTimer, 675, 0, fonts.mdigit, COL_DIGIT, {
		timeout = 87000,
		align = ALIGN_CENTER,
		sample_text = '88:88'
	} )
	MQTTDisplay( 'SunriseNonlard', "Meteo/Nonglard/sunrise", srf_sunrise )

	self.get():DrawStringTop("-", 764, 0)

	local srf_sunset = FieldBlink( self, animTimer, 795, 0, fonts.mdigit, COL_DIGIT, {
		timeout = 87000,
		align = ALIGN_CENTER,
		sample_text = '88:88'
	} )
	MQTTDisplay( 'SunsetNonlard', "Meteo/Nonglard/sunset", srf_sunset )

	local currentw = cweather( self, 0, 50 )
	local w0 = Weather3H(currentw, 'Meteo3H', 'Nonglard', 0)
	
	self.setColor( COL_BORDER )
	self.get():DrawLine(50,260, 380, 260)
	self.get():DrawLine(500,95, 500, 565)

	local stw,stwtopic = {}, {}
	for i=0,7 do
		stw[i] = ShortTermWeather(self, (i%4)*120, 280 + 185*math.floor(i/4))
		stwtopic[i] = Weather3H( stw[i], 'Meteo3H', 'Nonglard', i+1)
	end

	self.Visibility(false)
	return self
end

Meteo = meteo()

table.insert( winlist, Meteo )

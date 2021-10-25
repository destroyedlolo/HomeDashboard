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

	local FrogImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Grenouille.png")
	if not FrogImg then
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
		self.get():Blit(FrogImg, 240,230)

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

	local srf_sunset = FieldBlink( self, animTimer, 786, 0, fonts.mdigit, COL_DIGIT, {
		timeout = 87000,
		align = ALIGN_CENTER,
		sample_text = '88:88'
	} )
	MQTTDisplay( 'SunsetNonlard', "Meteo/Nonglard/sunset", srf_sunset )

	local Surveillance = ImageFiltreSurface( self, 880, 20, SELENE_SCRIPT_DIR .. "/Images/Oeil.png" )
	condition_Soleil = Condition( Surveillance, 0, { issue_color=COL_ORANGE } )
	heure_finsrv = FieldBlink( self, animTimer, 905, 10, fonts.sdigit, COL_DIGIT, {
		sample_text = '88:88'
	} )

	local currentw = cweather( self, 0, 50 )
	local w0 = Weather3H(currentw, 'Meteo3H', 'Nonglard', 0)
	
	self.setColor( COL_BORDER )
	self.get():DrawLine(50,260, 380, 260)
	self.get():DrawLine(500,95, 500, 565)

	local stw,stwtopic = {}, {}
	for _=0,7 do
		stw[_] = ShortTermWeather(self, (_%4)*120, 280 + 195*math.floor(_/4))
		stwtopic[_] = Weather3H( stw[_], 'Meteo3H', 'Nonglard', _+1)
	end

	self.setFont( fonts.sdigit )
	self.setColor( COL_TITLE )
	self.get():DrawString("Pour les prochains jours !", 540, 80)

	local ltw, ltwtopic = {}, {}
	for _=0,5 do
		ltw[_] = LongTermWeather(self, 520 + (_%7)*95, 100 + 125*math.floor(_/7))
		ltwtopic[_] = Weather( ltw[_], 'Meteo', 'Nonglard', _+1)
	end


	local temp = FieldBlink( self, animTimer, 935, 265, fonts.digit, COL_DIGIT, {
		timeout = 87000,
		align = ALIGN_CENTER,
		suffix = '°C',
		sample_text = '-88.88°C',
		gradient = GRD_TEMPERATURE
	} )

	local srf_Gfx = GfxArea( self, 530, 345, WINSIZE.w - 530, 290, COL_ORANGE, COL_TRANSPARENT20,{
		align = ALIGN_RIGHT,
		hlines={ { 0, COL_DARKBLUE } },
		heverylines={ {5, COL_DARKGREY}, { 10, COL_GREY } },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		transparency = true,
		min_delta = 10,
		ownsurface = true,
		gradient = GRD_TEMPERATURE
	} )

	local srf_maxtemp = FieldBlink( srf_Gfx, animTimer, 2, 2, fonts.sdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = '-88.88',
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_TEMPERATURE
	} )

	local srf_mintemp = FieldBlink( srf_Gfx, animTimer, 2, 285-fonts.sdigit.size, fonts.sdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = '-88.88',
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_TEMPERATURE
	} )

	local temp = MQTTStoreGfx( "TDehors", "maison/Temperature/Dehors", temp, srf_Gfx,
		{
			smax = srf_maxtemp,
			force_max_refresh = true,
			smin = srf_mintemp,
			force_min_refresh = true,
			condition=condition_network 
		}
	)
	table.insert( savedcols, temp )

	self.Visibility(false)
	return self
end

Meteo = meteo()

table.insert( winlist, Meteo )

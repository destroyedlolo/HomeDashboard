local function f()
	local self = Surface( psrf, 0,0,LBw, psrf:GetHight() )

	local fond,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/BarreGauche.png")
	if not fond then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear( 
		clipped -- clipping area from child (optional)
	)
		self.get():SaveContext()
		if clipped then
			self.get():SetClipS( unpack(clipped) )
		end

		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.get():Blit(fond, 0,0)	-- Notez-bien : translation is also scaled
		self.get():RestoreContext()
	end

	self.Clear()

	-- build graphics

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHight() )

	local offy = 8
	self.setColor( COL_TITLE )
	self.setFont( fonts.title1 )
	srf:DrawStringTop("Tension EDF :", 9, offy )
	offy = offy + self.get():GetFontExtents()

	local srf_tension = FieldBlink( self, animTimer, 30, offy, fonts.mseg, COL_DIGIT, {
		timeout = 30,
		ndecimal=0,
		align = ALIGN_RIGHT,
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		sample_text = "888"
	})
	self.setFont( fonts.mdigit )
	srf:DrawStringTop(" V", srf_tension.getAfter())

	local offx = srf_tension.getAfter() + srf:GetStringExtents(" V")
	local hc = HeureCreuse( self, offx+30,offy+2 )
	offy = offy + srf_tension.getHight() + 23

	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { condition=condition_network } )

		----

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Consommation :", 9, offy )
	offy = offy + self.get():GetFontExtents()

	local srf_consommation = Field( self, 30,offy, fonts.seg, COL_DIGIT, {
		timeout = 10,
		align = ALIGN_RIGHT, 
		sample_text = "12345",
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		gradient = GRD_CONSOMMATION
	} )
	self.setFont( fonts.mdigit )
	srf:DrawStringTop(" VA", srf_consommation.getAfter())
	offy = offy + srf_consommation.getHight()

	local srf_trndconso = GfxArea( self, 36,171, 120, 64, COL_ORANGE, COL_TRANSPARENT,{
		heverylines={ {1000, COL_DARKGREY} },
		align=ALIGN_RIGHT,
		transparency = true,
		ownsurface = true,
		gradient = GRD_CONSOMMATION,
		gradientA = GRD_CONSOMMATION_AVERAGE
	} )

	local srf_maxconso = FieldBlink( srf_trndconso, animTimer, 2, 2, fonts.sseg, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_CONSOMMATION
	} )

	local srf_minconso = FieldBlink( srf_trndconso, animTimer, 2, 62-fonts.sseg.size, fonts.sseg, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_CONSOMMATION
	} )

	local consommation = MQTTStoreGfx( 'consommation', 'TeleInfo/Consommation/values/PAPP', srf_consommation, srf_trndconso, 
		{
			average = true,
			group = 60,	-- average on minutes
			smax = srf_maxconso,
			force_max_refresh = true,
			smin = srf_minconso,
			force_min_refresh = true,
			forced_min = 0,
			minmax_round = true,
			condition=condition_network
		}
	)
	offy = 240

		-------

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Production :", 9, offy )
	offy = offy + self.get():GetFontExtents()

	local srf_production = Field( self, 30,offy, fonts.seg, COL_DIGIT, {
		timeout = 10,
		align = ALIGN_RIGHT, 
		sample_text = "12345", 
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		gradient = GRD_PRODUCTION
	} )
	self.setFont( fonts.mdigit )
	srf:DrawStringTop(" VA", srf_production.getAfter())
	offy = offy + srf_production.getHight()

	local srf_trndprod = GfxArea( self, 36, 320, 120, 64, COL_ORANGE, COL_TRANSPARENT,{
		heverylines={ {500, COL_DARKGREY} },
		align = ALIGN_RIGHT,
		ownsurface = true,
		transparency = true,
		gradient = GRD_PRODUCTION,
		gradientA = GRD_PRODUCTION_AVERAGE
	} )

	local srf_maxprod = Field( srf_trndprod, 2, 2, fonts.sseg, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_PRODUCTION
	} )

	local srf_minprod = FieldBlink( srf_trndprod, animTimer, 2, 62-fonts.sseg.size, fonts.sseg, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_PRODUCTION
	} )

	local production = MQTTStoreGfx( 'production', 'TeleInfo/Production/values/PAPP', srf_production, srf_trndprod,
		{
			average = true,
			group = 60,	-- average on minutes
			smax = srf_maxprod,
			force_max_refresh = true,
			smin = srf_minprod,
			force_min_refresh = true,
			forced_min = 0,
			minmax_round = true,
			condition=condition_network 
		}
	)

	offy = 408

		------------

	local srf_onduleur = FieldBlink( self, animTimer, 50, 72, fonts.sseg, COL_DIGIT, {
		timeout = 30,
		align = ALIGN_RIGHT, 
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		sample_text = "888.8 W",
		suffix = ' W'
	} )


	local onduleur = UPSdata('UPS', 'onduleur/ups.load', 'onduleur/ups.realpower.nominal', srf_onduleur, srf_gaugeOnduleur, { condition=condition_network })

		------------

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Salon :", 65, offy )
	offy = offy + self.get():GetFontExtents()

	local srf_TSalon = FieldBlink( self, animTimer, 65, offy, fonts.mseg, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_RIGHT, 
		sample_text = "-88.8",
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		gradient = GRD_TEMPERATURE
	} )

	local srf_Thermometre = VGauge( self, 42,439, 2,74, COL_RED, COL_WHITE, nil, {
		min = 5, max = 40,
		ascend = true
	})

	local TSalon = MQTTDisplay( 'TSalon', 'maison/Temperature/Salon', srf_TSalon )
	self.setFont( fonts.mdigit )
	srf:DrawStringTop("°C", srf_TSalon.getAfter())
	offy = offy + srf_TSalon.getHight()

	local function updthermo()
		srf_Thermometre.Draw( TSalon.get() )
	end
	TSalon.TaskOnceAdd( updthermo )

		----

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Extérieur :", 65, offy )
	offy = offy + self.get():GetFontExtents()

	self.srf_TDehors = FieldBlink( self, animTimer, 60, offy, fonts.mseg, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_RIGHT, 
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		sample_text = "-88.8",
		gradient = GRD_TEMPERATURE
	} )


	local TDehors = MQTTDisplay( 'TDehors', 'maison/Temperature/Dehors', self.srf_TDehors )
	self.setFont( fonts.mdigit )
	srf:DrawStringTop("°C", self.srf_TDehors.getAfter())
	offy = offy + self.srf_TDehors.getHight() + 10

		----

	self.setFont( fonts.sseg )
	imgw = self.get():GetStringExtents( "8888" )
	local srf_dATM = FieldBlink( self, animTimer, (w-imgw)/2, offy+15, fonts.sseg, COL_DIGIT, {
		timeout = 310,
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		align = ALIGN_CENTER,
		width = imgw
	} )
	local srf_uATM = FieldBlink( self, animTimer, (w-imgw)/2, offy + srf_dATM.getHight() + 15, fonts.sseg, COL_DIGIT, {
		timeout = 310,
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		align = ALIGN_CENTER,
		width = imgw
	} )

	local gfx_download = ArcGaugePercent( self, 
		36, offy,
		(w-imgw)/2-40, 3*srf_dATM.getHight(),
		{
			ownsurface=true,
			bgcolor = COL_TRANSPARENT,
--			parts = 1/32
		}
	)

	local gfx_upload = ArcGaugePercent( self, 
		w - (w-imgw)/2 +2, offy,
		(w-imgw)/2-40, 3*srf_dATM.getHight(),
		{
			ownsurface=true,
			bgcolor = COL_TRANSPARENT,
			align = ALIGN_RIGHT,
--			parts = 1/32
		}
	)

	local wdfreebox, _ = SelTimer.Create { when=40, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), ifunc= function ()
			Notification.setColor( COL_RED )
			Notification.Log( "Freebox muette")
			Notification.setColor( COL_WHITE )
			condition_freebox.report_issue()
		end
	}

	local dWAN = FAIdata( 'dWAN', 'Freebox/DownloadATM', 'Freebox/UploadTV', 'Freebox/DownloadWAN', srf_dATM, gfx_download, { watchdog=wdfreebox, condition=condition_freebox } )
	local uWAN = FAIdata( 'uWAN', 'Freebox/UploadATM', 'Freebox/DownloadTV', 'Freebox/UploadWAN', srf_uATM, gfx_upload )
	table.insert( additionnalevents, wdfreebox )

	--------

	local srf_consoj = Field( self, 40, 635, fonts.mcounter, COL_BLACK, {
		timeout = 30,
		align = ALIGN_RIGHT,
		ownsurface=true,
		bgcolor = COL_TRANSPARENT20,
		transparency = true,
		sample_text = "888888"
	})

	ConsoJ = MQTTDisplay( 'ConsoJ', MAJORDOME .. '/Electricite/Consommation', srf_consoj )

	local srf_prodj = Field( self, 50, 670, fonts.mcounter, COL_BLACK, {
		timeout = 300,
		align = ALIGN_RIGHT,
		ownsurface=true,
		bgcolor = COL_TRANSPARENT20,
		transparency = true,
		sample_text = "88888"
	})

	ProdJ = MQTTDisplay( 'ProdJ', MAJORDOME .. '/Electricite/Production', srf_prodj )

	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

LeftBar = f()


local function f()
	local self = Surface( psrf, 0,0,LBw, psrf:GetHight() )

	local fond,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/ToleRivets.png")
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
	local euroicn = ImageFiltreSurface( self, offx+30,offy+2, SELENE_SCRIPT_DIR .. "/Images/Euro.png" )
	condition_EDF = Condition( euroicn,0, {
		ok_color = COL_DARKORANGE,
		issue_color = COL_DARKGREEN
	} )
	offy = offy + srf_tension.getHight() + 12

	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { condition=condition_network } )

		----

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Consommation :", 9, offy )
	offy = offy + self.get():GetFontExtents()

	local grd_conso =  Gradient( {
		[500] = COL_DIGIT,
		[1500] = COL_ORANGE,
		[4500] = COL_RED
	})

	local srf_consommation = Field( self, 10,offy, fonts.seg, COL_DIGIT, {
		timeout = 10,
		align = ALIGN_RIGHT, 
		sample_text = "12345",
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		gradient = grd_conso
	} )
	self.setFont( fonts.mdigit )
	srf:DrawStringTop(" VA", srf_consommation.getAfter())
	offy = offy + srf_consommation.getHight()

	local srf_trndconso = GfxArea( self, 36,160, 120, 64, COL_ORANGE, COL_TRANSPARENT,{
		debug = true,
		heverylines={ {1000, COL_DARKGREY} },
		align=ALIGN_RIGHT,
		transparency = true,
		ownsurface = true,
		gradient = grd_conso
	} )

	local srf_maxconso = FieldBlink( srf_trndconso, animTimer, 2, 2, fonts.sseg, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = grd_conso
	} )

	local consommation = MQTTStoreGfx( 'consommation', 'TeleInfo/Consommation/values/PAPP', srf_consommation, srf_trndconso, 
		{
			smax = srf_maxconso,
			force_max_refresh = true,
			forced_min = 0,
			condition=condition_network
		}
	)
	offy = 226

		-------

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Production :", 9, offy )
	offy = offy + self.get():GetFontExtents()

	local grd_prod = Gradient( {
		[200] = COL_BLUE,
		[750] = COL_YELLOW,
		[1200] = COL_GREEN
	} )

	local srf_production = Field( self, 10,offy, fonts.seg, COL_DIGIT, {
		timeout = 10,
		align = ALIGN_RIGHT, 
		sample_text = "12345", 
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		gradient = grd_prod
	} )
	self.setFont( fonts.mdigit )
	srf:DrawStringTop(" VA", srf_production.getAfter())
	offy = offy + srf_production.getHight()

	local srf_trndprod = GfxArea( self, 36, 304, 120, 64, COL_ORANGE, COL_TRANSPARENT,{
		heverylines={ {500, COL_DARKGREY} },
		align = ALIGN_RIGHT,
		ownsurface = true,
		transparency = true,
		gradient = grd_prod
	} )

	local srf_maxprod = Field( srf_trndprod, 2, 2, fonts.sseg, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = grd_prod
	} )

	local production = MQTTStoreGfx( 'production', 'TeleInfo/Production/values/PAPP', srf_production, srf_trndprod,
		{
			smax = srf_maxprod,
			force_max_refresh = true,
			forced_min = 0,
			condition=condition_network 
		}
	)

	offy = 375 

		------------

	local srf_onduleur = FieldBlink( self, animTimer, 0, offy, fonts.sseg, COL_DIGIT, {
		timeout = 30,
		align = ALIGN_RIGHT, 
		sample_text = "888.8 W",
		suffix = ' W'
	} )

	offx = srf_onduleur.getAfter()

	local srf_gaugeOnduleur = HGauge( self, offx+2, offy+4, w-offx-4, srf_onduleur.get():GetHight()-6, COL_WHITE, COL_GFXBG, COL_BORDER )

	local onduleur = UPSdata('UPS', 'onduleur/ups.load', 'onduleur/ups.realpower.nominal', srf_onduleur, srf_gaugeOnduleur, { condition=condition_network })

	offy = offy + srf_onduleur.get():GetHight()

		------------

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Salon :", 35, offy )

	local img,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Thermometre.png")
	if not img then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	self.get():SaveContext()
	local imgw, imgh = img:GetSize()
	local simg = 115/imgh
	self.get():Scale( simg, simg )
	self.get():Blit(img, 5/simg, (offy+10)/simg)	-- Notez-bien : translation is also scaled
	self.get():RestoreContext()

	offy = offy + self.get():GetFontExtents()

	local srf_TSalon = FieldBlink( self, animTimer, 60, offy, fonts.mseg, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_RIGHT, 
		sample_text = "-88.8",
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		gradient = GRD_TEMPERATURE
	} )

	local srf_Thermometre = VGauge( self, 16,offy, 7,68, COL_RED, COL_WHITE, nil, {
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
	srf:DrawStringTop("Extérieur :", 35, offy )
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
	offy = offy + self.srf_TDehors.getHight()

		----

	self.setFont( fonts.sdigit )
	imgw = self.get():GetStringExtents( "8888" )
	local srf_dATM = FieldBlink( self, animTimer, (w-imgw)/2, offy+15, fonts.sseg, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_CENTER,
		width = imgw
	} )
	local srf_uATM = FieldBlink( self, animTimer, (w-imgw)/2, offy + srf_dATM.getHight() + 15, fonts.sseg, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_CENTER,
		width = imgw
	} )

	local gfx_download = ArcGaugePercent( self, 
		0, offy,
		(w-imgw)/2-5, 3*srf_dATM.getHight(),
		{
			parts = 1/32
		}
	)

	local gfx_upload = ArcGaugePercent( self, 
		w - (w-imgw)/2 +2, offy,
		(w-imgw)/2-5, 3*srf_dATM.getHight(),
		{
			align = ALIGN_RIGHT,
			parts = 1/32
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

--	offy = offy + srf_dATM.getHight()



	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

LeftBar = f()


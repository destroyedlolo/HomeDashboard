local function f()
	local self = Surface( psrf, 0,0,LBw, psrf:GetHight() )

	-- build graphics

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHight() )

	local offy = 0
	self.setColor( COL_TITLE )
	self.setFont( fonts.title1 )
	srf:DrawStringTop("Tension EDF :", 5, offy )
	offy = offy + self.get():GetFontExtents()

	local srf_tension = FieldBlink( self, animTimer, 10, offy, fonts.mdigit, COL_DIGIT, {
		timeout = 30,
		ndecimal=0,
		align = ALIGN_RIGHT,
		width = LBw - 20,
		suffix = " V"
	})
	offy = offy + srf_tension.getHight()

	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { condition=condition_network } )

		----

	srf:DrawStringTop("Consommation :", 5, offy )
	offy = offy + self.get():GetFontExtents()

	local grd_conso =  Gradient( {
		[500] = COL_DIGIT,
		[1500] = COL_ORANGE,
		[4500] = COL_RED
	})

	local srf_consommation = Field( self, 10,offy, fonts.digit, COL_DIGIT, {
		timeout = 10,
		suffix = ' VA',
		align = ALIGN_RIGHT, 
		width = LBw - 20,
		gradient = grd_conso
	} )
	offy = offy + srf_consommation.getHight()

	local srf_trndconso = GfxArea( self, 0, offy, w-5, HSGRPH, COL_ORANGE, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		align=ALIGN_RIGHT,
		gradient = grd_conso
	} )

	local srf_maxconso = FieldBlink( self, animTimer, 0, offy, fonts.sdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		ownsurface = true,
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
	offy = offy + HSGRPH

		-------

	srf:DrawStringTop("Production :", 5, offy )
	offy = offy + self.get():GetFontExtents()

	local grd_prod = Gradient( {
		[200] = COL_BLUE,
		[750] = COL_YELLOW,
		[1200] = COL_GREEN
	} )

	local srf_production = Field( self, 10,offy, fonts.digit, COL_DIGIT, {
		timeout = 10,
		align = ALIGN_RIGHT, 
		suffix = ' VA',
		width = LBw - 20,
		gradient = grd_prod
	} )
	offy = offy + srf_production.getHight()

	local srf_trndprod = GfxArea( self, 0, offy, w-5, HSGRPH, COL_ORANGE, COL_GFXBG,{
		heverylines={ {500, COL_DARKGREY} },
		align = ALIGN_RIGHT,
		gradient = grd_prod
	} )

	local srf_maxprod = FieldBlink( self, animTimer, 0, offy, fonts.sdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		ownsurface = true,
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

	offy = offy + HSGRPH

		------------

--[[
	local srf_onduleur = FieldBlink( self, animTimer, 0, offy, fonts.sdigit, COL_DIGIT, {
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
	local simg = 90/imgh
	self.get():Scale( simg, simg )
	self.get():Blit(img, 5/simg, (offy+5)/simg)	-- Notez-bien : translation is also scaled
	self.get():RestoreContext()

	offy = offy + self.get():GetFontExtents()

	local srf_TSalon = FieldBlink( self, animTimer, 50, offy, fonts.mdigit, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_RIGHT, 
		sample_text = "-88.8",
		gradient = GRD_TEMPERATURE
	} )

	local srf_Thermometre = VGauge( self, 14,330, 6,62, COL_RED, COL_WHITE, nil, {
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

	self.srf_TDehors = FieldBlink( self, animTimer, 50, offy, fonts.mdigit, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_RIGHT, 
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
	local srf_dATM = FieldBlink( self, animTimer, (w-imgw)/2, offy+15, fonts.sdigit, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_CENTER,
		width = imgw
	} )
	local srf_uATM = FieldBlink( self, animTimer, (w-imgw)/2, offy + srf_dATM.getHight() + 15, fonts.sdigit, COL_DIGIT, {
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

--]]

	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

LeftBar = f()


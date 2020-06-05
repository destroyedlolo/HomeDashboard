local function f()
	self = Surface( psrf, 0,0,LBw, psrf:GetHight() )

	-- build graphics

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHight() )

	local offy = 3 
	self.setColor( COL_TITLE )
	self.setFont( fonts.title1 )
	srf:DrawStringTop("Tension EDF :", 5, offy )
	offy = offy + self.get():GetFontExtents()

	local srf_tension = FieldBlink( self, animTimer, 30, offy, fonts.mdigit, COL_DIGIT, {
		timeout = 30,
		ndecimal=0,
		align = ALIGN_RIGHT,
		sample_text = "888"
	})
	self.setFont( fonts.mdigit )
	srf:DrawStringTop(" V", srf_tension.getAfter())
	offy = offy + srf_tension.getHight()

	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { condition=condition_network } )

		----

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Consommation :", 5, offy )
	offy = offy + self.get():GetFontExtents()

	local srf_consommation = Field( self, 10,offy, fonts.digit, COL_DIGIT, {
		timeout = 10,
		align = ALIGN_RIGHT, 
		sample_text = "12345", 
		gradient = Gradient(
			{
				[500] = COL_DIGIT,
				[1500] = COL_ORANGE,
				[4500] = COL_RED
			}
		)
	} )
	self.setFont( fonts.digit )
	srf:DrawStringTop(" VA", srf_consommation.getAfter())
	offy = offy + srf_consommation.getHight()

	local srf_trndconso = GfxArea( self, 0, offy, w-5, HSGRPH, COL_ORANGE, COL_GFXBG,{
		heverylines={ {5000, COL_DARKGREY} },
		align=ALIGN_RIGHT 
	} )

	local srf_maxconso = FieldBlink( self, animTimer, 0, offy, fonts.sdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		ownsurface = true,
		gradient = Gradient(
			{
				[500] = COL_DIGIT,
				[1500] = COL_ORANGE,
				[4500] = COL_RED
			}
		)
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

	self.setFont( fonts.title1 )
	srf:DrawStringTop("Production :", 5, offy )
	offy = offy + self.get():GetFontExtents()

	local srf_production = Field( self, 10,offy, fonts.digit, COL_DIGIT, {
		timeout = 10,
		align = ALIGN_RIGHT, 
		sample_text = "12345", 
		gradient = Gradient(
			{
				[200] = COL_BLUE,
				[750] = COL_YELLOW,
				[1200] = COL_GREEN
			}
		)
	} )
	self.setFont( fonts.digit )
	srf:DrawStringTop(" VA", srf_production.getAfter())
	offy = offy + srf_production.getHight()

	local srf_trndprod = GfxArea( self, 0, offy, w-5, HSGRPH, COL_ORANGE, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		align = ALIGN_RIGHT 
	} )

	local srf_maxprod = FieldBlink( self, animTimer, 0, offy, fonts.sdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345",
		bgcolor = COL_TRANSPARENT,
		ownsurface = true,
		gradient = Gradient(
			{
				[200] = COL_BLUE,
				[750] = COL_YELLOW,
				[1200] = COL_GREEN
			}
		)
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

	local srf_onduleur = FieldBlink( self, animTimer, 0, offy, fonts.sdigit, COL_DIGIT, {
		timeout = 30,
		align = ALIGN_RIGHT, 
		sample_text = "888.8 W",
		suffix = ' W'
	} )

	local offx = srf_onduleur.getAfter()

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

	local srf_Thermometre = VGauge( self, 14,270, 6,62, COL_RED, COL_WHITE, nil, {
		min = 5, max = 40,
		ascend = true
	})
-- 14,328
-- 20,266
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
	offy = offy + srf_dATM.getHight()
	local srf_uATM = FieldBlink( self, animTimer, (w-imgw)/2, offy, fonts.sdigit, COL_DIGIT, {
		timeout = 310,
		align = ALIGN_CENTER,
		width = imgw
	} )
	local dWAN = FAIdata( 'dWAN', 'Freebox/DownloadATM', 'Freebox/UploadTV', 'Freebox/DownloadWAN', srf_dATM, srf_dnGfx )
	local uWAN = FAIdata( 'uWAN', 'Freebox/UploadATM', 'Freebox/DownloadTV', 'Freebox/UploadWAN', srf_uATM, srf_upGfx )



	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

LeftBar = f()


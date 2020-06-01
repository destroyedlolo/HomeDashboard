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
	srf:DrawStringTop("Consomation :", 5, offy )
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

	local consomation = MQTTStoreGfx( 'consomation', 'TeleInfo/Consommation/values/PAPP', srf_consommation, srf_trndconso, 
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
		align=ALIGN_RIGHT 
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

	local srf_gaugeOnduleur = GaugeHPercent( self, offx+2, offy+2, w-offx-4, srf_onduleur.get():GetHight()-4, COL_WHITE, COL_GFXBG, COL_BORDER )

	local onduleur = UPSdata('UPS', 'onduleur/ups.load', 'onduleur/ups.realpower.nominal', srf_onduleur, srf_gaugeOnduleur, { condition=condition_network })

	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

LeftBar = f()


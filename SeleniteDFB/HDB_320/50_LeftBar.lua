local function f()
	self = SubSurface( psrf, 0,0, LBw,psrf:GetHeight() )

	-- build graphics

	local w = self.get():GetWidth()-1
	local srf = self.get()

	local ThermImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/ElectricityBG.png")
	local x,y = ThermImg:GetSize()
	ThermImg:RenderTo( srf, { 0, 0, x,y } )
	ThermImg:Release()

	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHeight() )

	local offy = 3
	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("Tension EDF :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	self.refresh()	-- refresh the background to let subSurface to backup the background if needed

	local srf_tension = FieldBackgroundBlink( srf, animTimer, 10,offy, fmdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		width = w-20 
	})
	offy = offy + srf_tension:GetHeight()
	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { suffix=' V', condition=condition_network } )


	srf:DrawString("Consomation :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	local srf_consommation = FieldBackBorder( srf, 10,offy, fdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		width = w-20 
	} )
	offy = offy + srf_consommation:GetHeight()

	x = w - (5 + fsdigit:StringWidth("12345"))

	local srf_trndconso = GfxArea( srf, 0, offy, x-5, HSGRPH, COL_TRANSPARENT, COL_GFXBG, { align=ALIGN_RIGHT } )
	srf_trndconso.get():FillGrandient { TopLeft={40,40,40,255}, BottomLeft={40,40,40,255}, TopRight={255,96,32,255}, BottomRight={32,255,32,255} }
	srf_trndconso.FrozeUnder()

	local srf_maxconso = FieldBackgroundBlink( srf, animTimer, x, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345"
	} )
	offy = offy + HSGRPH

	local consomation = MQTTStoreGfx( 'consomation', 'TeleInfo/Consommation/values/PAPP', srf_consommation, srf_trndconso, srf_maxconso,
		{
			suffix = ' VA', 
			gradient = Gradient(
				{
					[500] = COL_DIGIT,
					[1500] = COL_ORANGE,
					[4500] = COL_RED
				}
			),
			forced_min = 0
		}
	)

	srf:DrawString("Production :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	local srf_production = FieldBackground( srf, 10,offy, fdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		width = w-20 
	} )
	offy = offy + srf_production:GetHeight()

-- already calculated
--	x = w - (5 + fsdigit:StringWidth("12345"))

	local srf_trndprod = GfxArea( srf, 0, offy, x-5, HSGRPH, COL_TRANSPARENT, COL_GFXBG, { align=ALIGN_RIGHT } )
	srf_trndprod.get():FillGrandient { TopLeft={40,40,40,255}, BottomLeft={40,40,40,255}, TopRight={32,255,32,255}, BottomRight={32,255,255,255} }
	srf_trndprod.FrozeUnder()

	local srf_maxprod = FieldBackgroundBlink( srf, animTimer, x, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "12345"
	} )
	offy = offy + HSGRPH
	local production = MQTTStoreGfx( 'production', 'TeleInfo/Production/values/PAPP', srf_production, srf_trndprod, srf_maxprod,
		{ suffix = ' VA', forced_min = 0 } )

	local srf_onduleur = FieldBlink( srf, animTimer, 0, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "888.8W"
	} )
	x = srf_onduleur.get():GetWidth()
	local srf_gaugeOnduleur = GaugeHPercentBg( srf, x+4, offy+4, w-x-8, srf_onduleur.get():GetHeight()-8, COL_GFXBG, COL_BORDER )
	local onduleur = UPSdata('UPS', 'onduleur/ups.load', 'onduleur/ups.realpower.nominal', srf_onduleur, srf_gaugeOnduleur)
	offy = offy + srf_gaugeOnduleur.get():GetHeight() + 6


--
-- Key temperatures
--
	
	local srf_TSalon = FieldBlink( srf, animTimer, w-8, offy, fdigit, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8°"
	})
	local TSalon = MQTTDisplay( 'TSalon', 'maison/Temperature/Salon', srf_TSalon, { suffix='°' } )
	offy = offy + srf_TSalon:GetHeight()

	local srf_TDehors = FieldBlink( srf, animTimer, w-8, offy, fdigit, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8°"
	})
	local TDehors = MQTTDisplay( 'TDehors', 'maison/Temperature/Dehors', srf_TDehors, { suffix='°', gradient = GRD_TEMPERATURE } )
	offy = offy + srf_TDehors:GetHeight()

	local srf_TBureau = FieldBlink( srf, animTimer, w-8, offy, fdigit, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8°"
	})
	local TBureau = MQTTDisplay( 'TBureau', 'maison/Temperature/Bureau', srf_TBureau, { suffix='°', gradient = GRD_TEMPERATURE } )


	w,y = srf_TSalon.get():GetPosition()	-- Determine remaining room origine
	offy = srf:GetHeight() - fsdigit:GetHeight()
	local srf_uATM = FieldBlink( srf, animTimer, (w-fsdigit:StringWidth("0000"))/2 , offy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		sample_text = "0000"
	} )
	offy = offy - srf_uATM:GetHeight()

	local srf_dATM = FieldBlink( srf, animTimer, (w-fsdigit:StringWidth("0000"))/2 , offy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		sample_text = "0000"
	} )
	offy = offy - srf_dATM:GetHeight()
	
	local srf_dnGfx = ArcGaugePercent(srf, 0, y, w/2, offy-y, 5, 2, { emptycolor=COL_GFXBG })
	local srf_upGfx = ArcGaugePercent(srf, w/2, y, w/2, offy-y, 5, 1, { emptycolor=COL_GFXBG })

	local dWAN = FAIdata( 'dWAN', 'Freebox/DownloadATM', 'Freebox/UploadTV', 'Freebox/DownloadWAN', srf_dATM, srf_dnGfx )
	local uWAN = FAIdata( 'uWAN', 'Freebox/UploadATM', 'Freebox/DownloadTV', 'Freebox/UploadWAN', srf_uATM, srf_upGfx )


	self.refresh()

	return self
end

LeftBar = f()

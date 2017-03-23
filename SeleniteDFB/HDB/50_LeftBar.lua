local function f()
	self = SubSurface( psrf, 0,0, 160,psrf:GetHeight() )

	-- build graphics
	local HSGRPH = 30	-- Height of small graphs

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHeight() )

--[[
	local ElecBgImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/ElectricityBG.png")
	local x,y = ElecBgImg:GetSize()
	ElecBgImg:RenderTo( srf, { 20, 40, x,y } )
	ElecBgImg:Release()
--]]
	local offy = 3
	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("Tension EDF :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	self.refresh()	-- refresh the background to let subSurface to backup the background if needed

	local srf_tension = FieldBackgroundBlink( srf, animTimer, 10,offy, fmdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "888.0 V", 
		width = w-20 
	})
	offy = offy + srf_tension:GetHeight()
	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { suffix=' V' } )


	srf:DrawString("Consomation :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	local srf_consommation = FieldBackBorder( srf, 10,offy, fdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "12345", 
		width = w-20 
	} )
	offy = offy + srf_consommation:GetHeight()

	x = w - (5 + fsdigit:StringWidth("12345"))

	local srf_trndconso = GfxArea( srf, 0, offy, x-5, HSGRPH, COL_GFXFG, COL_GFXBG )

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
		sample_text = "12345", 
		width = w-20 
	} )
	offy = offy + srf_production:GetHeight()

-- already calculated
--	x = w - (5 + fsdigit:StringWidth("12345"))

	local srf_trndprod = GfxArea( srf, 0, offy, x-5, HSGRPH, COL_GFXFG, COL_GFXBG )

	local srf_maxprod = FieldBackgroundBlink( srf, animTimer, x, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "12345"
	} )
	local production = MQTTStoreGfx( 'production', 'TeleInfo/Production/values/PAPP', 
		srf_production, srf_trndprod, srf_maxprod,
		{ suffix = ' VA', forced_min = 0 }
	)
	offy = offy + HSGRPH + 3


	local srf_onduleur = FieldBlink( srf, animTimer, 0, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "888.8W"
	} )
	x = srf_onduleur.get():GetWidth()
	local srf_gaugeOnduleur = GaugeHPercentBg( srf, x+4, offy+8, w-x-8, srf_onduleur.get():GetHeight()-16, COL_GFXBG, COL_BORDER )
	local onduleur = UPSdata('UPS', 'onduleur/ups.load', 'onduleur/ups.realpower.nominal', srf_onduleur, srf_gaugeOnduleur)
	offy = offy + srf_onduleur.get():GetHeight() + 2


--
-- Key temperatures
--
-- A revoir quand la météo et les temperatures seront en place
--

	offy = offy + ftitle1:GetHeight()

	local ThermImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/Thermometre.png") 
	assert(ThermImg, "Can't load image")

	ThermImg:RenderTo( srf, { 5, offy, 25,90 } )
	ThermImg:Release()

	local srf_TSalon = FieldBlink( srf, animTimer, w-8, offy, fdigit, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8°C"
	})
	srf:DrawString("Salon :", srf_TSalon.get():GetPosition(), offy - ftitle1:GetHeight() )
	local srf_Thermometre = GaugeRange( srf, 14,325, 6, 63, COL_RED, COL_WHITE, 5,35, { vertical = true } )
	local TSalon = MQTTDisplay( 'TSalon', 'maison/Temperature/Salon', srf_TSalon, { suffix='°C', gradient = GRD_TEMPERATURE } )
	offy = offy + srf_TSalon:GetHeight()

-- A mettre avec la temperature du salon
local function updthermo()
	srf_Thermometre.Draw( TSalon.get() )
end
TSalon.TaskOnceAdd( updthermo )
----

	offy = offy + ftitle1:GetHeight()
	local srf_TDehors = FieldBlink( srf, animTimer, w-8, offy, fdigit, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8°C"
	})
	srf:DrawString("Extérieur :", srf_TDehors.get():GetPosition(), offy - ftitle1:GetHeight() )
	local TDehors = MQTTDisplay( 'TDehors', 'maison/Temperature/Dehors', srf_TDehors, { suffix='°C', gradient = GRD_TEMPERATURE } )
	offy = offy + srf_TDehors:GetHeight()

--[[
	self.setColor( COL_BORDER )
	srf:DrawLine( 0, offy, w, offy )
]]

	offy = offy+2
	local srf_dATM = FieldBlink( srf, animTimer, (w-fsdigit:StringWidth("0000"))/2 , offy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		sample_text = "0000"
	} )
	offy = offy + srf_dATM:GetHeight()

	local srf_uATM = FieldBlink( srf, animTimer, (w-fsdigit:StringWidth("0000"))/2 , offy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		sample_text = "0000"
	} )

	x,y = srf_dATM.get():GetPosition()
	local srf_dnGfx = ArcGaugePercent(srf, 0, y, x-4, srf_dATM:GetHeight() + srf_uATM:GetHeight(), 10, 2, { emptycolor=COL_GFXBG })

	x = x + srf_dATM.get():GetWidth() + 4
	local srf_upGfx = ArcGaugePercent(srf, x, y, w - x, srf_dATM:GetHeight() + srf_uATM:GetHeight(), 10, 1, { emptycolor=COL_GFXBG })

--[[
	local dWAN = MQTTDisplay( 'dWAN', 'Freebox/DownloadATM', srf_dATM )
	local uWAN = MQTTDisplay( 'uWAN', 'Freebox/UploadATM', srf_uATM )
]]
	local dWAN = FAIdata( 'dWAN', 'Freebox/DownloadATM', 'Freebox/UploadTV', 'Freebox/DownloadWAN', srf_dATM, srf_dnGfx )
	local uWAN = FAIdata( 'uWAN', 'Freebox/UploadATM', 'Freebox/DownloadTV', 'Freebox/UploadWAN', srf_uATM, srf_upGfx )

	self.refresh()

	return self
end

LeftBar = f()

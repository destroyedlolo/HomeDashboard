local function f()
	self = SubSurface( psrf, 0,0, 160,psrf:GetHeight() )

	-- build graphics
	local HSGRPH = 30	-- Height of small graphs

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHeight() )

	local ThermImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/ElectricityBG.png")
	local x,y = ThermImg:GetSize()
	ThermImg:RenderTo( srf, { 20, 40, x,y } )
	ThermImg:Release()

	local offy = 3
	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("Tension EDF :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	self.refresh()	-- refresh the background to let subSurface to backup the background if needed

	local srf_tension = FieldBackgroundBlink( srf, animTimer, 10,offy, fmdigit, ALIGN_RIGHT, COL_DIGIT, "888.0 V", w-20 )
	offy = offy + srf_tension:GetHeight()
	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { suffix=' V' } )


	srf:DrawString("Consomation :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	local srf_consommation = FieldBackBorder( srf, 10,offy, fdigit, ALIGN_RIGHT, COL_DIGIT, "12345", w-20 )
	offy = offy + srf_consommation:GetHeight()

	x = w - (5 + fsdigit:StringWidth("12345"))

--	local srf_trndconso = GfxAreaBackground( srf, 0, offy, x-5, HSGRPH, COL_RED )
	local srf_trndconso = GfxArea( srf, 0, offy, x-5, HSGRPH, COL_GFXFG, COL_GFXBG )

	local srf_maxconso = FieldBackgroundBlink( srf, animTimer, x, offy, fsdigit, ALIGN_RIGHT, COL_DIGIT, "12345")
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
	local srf_production = FieldBackground( srf, 10,offy, fdigit, ALIGN_RIGHT, COL_DIGIT, "12345", w-20 )
	offy = offy + srf_production:GetHeight()

-- already calculated
--	x = w - (5 + fsdigit:StringWidth("12345"))

	local srf_trndprod = GfxArea( srf, 0, offy, x-5, HSGRPH, COL_GFXFG, COL_GFXBG )

	local srf_maxprod = FieldBackgroundBlink( srf, animTimer, x, offy, fsdigit, ALIGN_RIGHT, COL_DIGIT, "12345")
	offy = offy + HSGRPH

	local production = MQTTStoreGfx( 'production', 'TeleInfo/Production/values/PAPP', srf_production, srf_trndprod, srf_maxprod,
		{ suffix = ' VA', forced_min = 0 } )

	local srf_onduleur = FieldBlink( srf, animTimer, 0, offy, fsdigit, ALIGN_RIGHT, COL_DIGIT, "888.8W")
	local onduleur = UPSdata('UPS', 'onduleur/ups.load', nil, 'onduleur/ups.realpower.nominal', srf_onduleur)

	self.refresh()

--[[
srf_tension.update('124.0 V')
srf_consommation.update('12345')
srf_maxconso.update('12345')
srf_production.update('12345')
srf_maxprod.update('12345')
]]

	return self
end

LeftBar = f()

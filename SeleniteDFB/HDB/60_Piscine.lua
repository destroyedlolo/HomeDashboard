-- Sonde de la piscine

local function piscine()
		local self = {}

	local window = layer:CreateWindow {
		pos = WINTOP, size = WINSIZE,
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE'),
	}
	window:SetOpacity(0xff)	-- Make the window visible
	table.insert( winlist, window )
	local srf = window:GetSurface()
	srf:Clear( COL_BLACK.get() )

	srf:SetColor( COL_TITLE.get() )
	srf:SetFont( ftitle )
	srf:DrawString("Piscine", 0, 0)
	local offy = ftitle:GetHeight()

	local szx, szy = 
		WINSIZE[1],
		(WINSIZE[2] - offy - BBh - ftitle1:GetHeight())/3

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .."/Images/Poseidon.png")
	assert(img)
	local offx,y = img:GetSize()
	img:RenderTo( srf, { 5, WINSIZE[2]-y-15, offx, y } )
	img:destroy()
	offx = offx + 15	-- Sub gfx offset

	local grTension = Gradient(
		{
			[2500] = COL_RED,
			[2800] = COL_ORANGE,
			[3200] = COL_GREEN,
			[3500] = COL_RED
		}
	)

	srf:SetFont( ftitle1 )
	srf:SetColor( COL_TITLE.get() )
	srf:DrawString("Température Piscine :", 0, offy)
	local srf_tPiscine = Field( srf, 5 + ftitle1:StringWidth("Temperature Piscine :"), offy, fsdigit, COL_DIGIT, {
		timeout = 360,
		align = ALIGN_RIGHT,
		sample_text = "20.31 °C"
	} )
	offy = offy + ftitle1:GetHeight()

	local srfg_tPiscine = GfxArea( srf, 0,offy, szx, szy, COL_RED, COL_GFXBG,{
		heverylines={ {5, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	szx = szx - offx - 5

	local tPiscine = MQTTStoreGfx( 'tPiscine', 'SondePiscine/TempPiscine', srf_tPiscine, srfg_tPiscine, 
		{ suffix = ' °', forced_min = 15, rangeMin = -100, rangeMax = 100 }
	)
	table.insert( savedcols, tPiscine)
	offy = offy + szy

	srf:DrawString("Température Sonde :", offx, offy)
	local srf_tSonde = Field( srf, offx + ftitle1:StringWidth("Temperature Sonde :"), offy, fsdigit, COL_DIGIT, {
		timeout = 360,
		align = ALIGN_RIGHT,
		sample_text = "20.31 °C"
	} )
	offy = offy + ftitle1:GetHeight()

	local srfg_tSonde = GfxArea( srf, offx,offy, szx, szy, COL_RED, COL_GFXBG,{
		heverylines={ {5, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local tSonde = MQTTStoreGfx( 'tSonde', 'SondePiscine/TempInterne', srf_tSonde, srfg_tSonde, 
		{ suffix = ' °C', forced_min = 0, rangeMin = -100, rangeMax = 100 }
	)
	table.insert( savedcols, tSonde)
	offy = offy + szy

	srf:DrawString("Vcc :", offx, offy)
	srf:DrawString("WiFi :", offx + szx/3, offy)
	srf:DrawString("MQTT :", offx + 2 * szx/3, offy)
	local srf_Tens = Field( srf, offx + ftitle1:StringWidth("Vcc : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srf_WiFi = Field( srf, offx + szx/3 + ftitle1:StringWidth("WiFi : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srf_MQTT = Field( srf, offx + 2*szx/3 + ftitle1:StringWidth("MQTT : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	offy = offy + ftitle1:GetHeight()
	local srfg_Tens = GfxArea( srf, offx, offy, szx/3-5, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local Tens = MQTTStoreGfx( 'PTens', 'SondePiscine/Vcc', srf_Tens, srfg_Tens, 
		{ xsmax=srf_maxprod, forced_min = 2}
	)
	table.insert( savedcols, Tens)
	local srfg_WiFi = GfxArea( srf, offx+szx/3,offy, szx/3-5, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local WiFi = MQTTStoreGfx( 'PWiFi', 'SondePiscine/WiFi', srf_WiFi, srfg_WiFi, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, WiFi)

	local srfg_MQTT = GfxArea( srf, offx+2*szx/3,offy +5, szx/3-5, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local MQTT = MQTTStoreGfx( 'PMQTT', 'SondePiscine/MQTT', srf_MQTT, srfg_MQTT, 
		{ forced_min = 0}
	)
	table.insert( savedcols, MQTT)	

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Piscine = piscine()

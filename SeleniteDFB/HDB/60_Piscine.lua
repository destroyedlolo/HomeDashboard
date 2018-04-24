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
	img:RenderTo( srf, { 5, WINSIZE[2]-y-5, offx, y } )
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
	local srf_tPiscine = FieldBlink( srf, animTimer, 5 + ftitle1:StringWidth("Temperature Piscine :"), offy, fsdigit, COL_DIGIT, {
		timeout = 2100,		-- 35 minutes
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
		{ suffix = ' °C', forced_min = 15, rangeMin = -100, rangeMax = 100 }
	)
	table.insert( savedcols, tPiscine)
	offy = offy + szy

	srf:DrawString("Vcc :", offx - 100, offy)
	srf:DrawString("WiFi :", offx + szx/3, offy)
	srf:DrawString("MQTT :", offx + 2 * szx/3, offy)
	local srf_Tens = FieldBlink( srf, animTimer, offx - 100 + ftitle1:StringWidth("Vcc : "), offy, fsdigit, COL_DIGIT, {
		timeout = 2100,		-- 35 minutes
		gradient = grTension,
		align = ALIGN_RIGHT,
		sample_text = "3333 mV"
	} )
	local srf_WiFi = FieldBlink( srf, animTimer, offx + szx/3 + ftitle1:StringWidth("WiFi : "), offy, fsdigit, COL_DIGIT, {
		timeout = 2100,		-- 35 minutes
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srf_MQTT = FieldBlink( srf, animTimer, offx + 2*szx/3 + ftitle1:StringWidth("MQTT : "), offy, fsdigit, COL_DIGIT, {
		timeout = 2100,		-- 35 minutes
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	offy = offy + ftitle1:GetHeight()

	local srf_MaxTens = FieldBackBorder( srf, offx - 95, offy+5, fsdigit, COL_ORANGE, {
		align = ALIGN_RIGHT,
		gradient = grTension,
		keepbackground = true,
		sample_text = "8888"
	} )
	local srf_MinTens = FieldBackBorder( srf, offx - 95, offy + szy - fsdigit:GetHeight() - 5, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		gradient = grTension,
		keepbackground = true,
		sample_text = "8888"
	} )
	local srfg_Tens = GfxArea( srf, offx - 100, offy, szx/3+95, szy, COL_RED, COL_GFXBG,{
		heverylines={ {100, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local Tens = MQTTStoreGfx( 'PTens', 'SondePiscine/Vcc', srf_Tens, srfg_Tens, 
		{ 
			smax=srf_MaxTens, smin=srf_MinTens,
			suffix = ' mV',
			force_max_refresh = 1, force_min_refresh = 1,
			xforced_min = 2.5
		}
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
	offy = offy + szy

	srf:DrawString("Température Sonde :", offx, offy)
	local srf_tSonde = FieldBlink( srf, animTimer, offx + ftitle1:StringWidth("Temperature Sonde :"), offy, fsdigit, COL_DIGIT, {
		timeout = 2100,		-- 35 minutes
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

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Piscine = piscine()

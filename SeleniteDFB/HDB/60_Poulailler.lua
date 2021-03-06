-- Vient poupoule vient

local function poulailler()
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
	srf:DrawString("Poulailler", 0, 0)
	local offy = ftitle:GetHeight()

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .."/Images/Poule.png")
	assert(img)
	local x,y = img:GetSize()
	img:RenderTo( srf, { 0, ftitle:GetHeight(), x, y } )
	img:destroy()

	local grTension = Gradient(
		{
			[4500] = COL_RED,
			[4600] = COL_ORANGE,
			[4900] = COL_GREEN,
			[5500] = COL_RED
		}
	)

	local srfg_nRep = GfxArea( srf, 75, 59, 126, 38, COL_GREEN, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local srf_nRep = Field( srf, 145,103, fsdigit, COL_DIGIT, {
		timeout = 70,
		align = ALIGN_RIGHT,
		sample_text = "33"
	} )
	local nRep = MQTTStoreGfx( 'nRep', 'ESPRouter_Domo/NoStations', srf_nRep, srfg_nRep, 
		{ forced_min = 0}
	)
	table.insert( savedcols, nRep)

	srf:SetFont( ftitle1 )
	srf:SetColor( COL_TITLE.get() )
	offy = 0
	srf:DrawString("Alimentation :", 310, offy)
	local srf_vPoul = FieldBlink( srf, animTimer, 315 + ftitle1:StringWidth("Alimentation :"), offy + ftitle1:GetHeight() - fsdigit:GetHeight(), fsdigit, COL_DIGIT, {
		timeout = 360,
		gradient = grTension,
		align = ALIGN_RIGHT,
		suffix = ' mV',
		sample_text = "3333 mV"
	} )
	offy = offy + ftitle1:GetHeight()

	local srfg_vPoul = GfxArea( srf, 310, offy, 320, 70, COL_GREEN, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local vPoul = MQTTStoreGfx( 'vPoul', 'Poulailler/Alim', srf_vPoul, srfg_vPoul, 
		{ xsmax=srf_maxprod, suffix = ' mV', xforced_min = 0}
	)
	table.insert( savedcols, vPoul)
	offy = offy + 75

	srf:DrawString("Température :", 310, offy)
	local srf_tPoul = FieldBlink( srf, animTimer, 315 + ftitle1:StringWidth("Température :"), offy + ftitle1:GetHeight() - fsdigit:GetHeight(), fsdigit, COL_DIGIT, {
		timeout = 360,
		gradient = GRD_TEMPERATURE,
		align = ALIGN_RIGHT,
		suffix = ' °',
		sample_text = "-99.99 °"
	} )
	offy = offy + ftitle1:GetHeight()

	local srfg_tPoul = GfxArea( srf, 310, offy, 320, 70, COL_RED, COL_GFXBG,{
		heverylines={ {5, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local srf_MaxTPoul = FieldBackBorder( srf, 315, offy+5, fsdigit, COL_ORANGE, {
		align = ALIGN_RIGHT,
		keepbackground = true,
		sample_text = "-88.88",
		ndecimal = 2
	} )
	local srf_MinTPoul = FieldBackBorder( srf, 315, offy + 68 - fsdigit:GetHeight(), fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		keepbackground = true,
		sample_text = "-88.88",
		ndecimal = 2
	} )

	local tPoul = MQTTStoreGfx( 'tPoul', 'Poulailler/Perchoir/Temperature', srf_tPoul, srfg_tPoul, 
		{
			smax=srf_MaxTPoul, smin=srf_MinTPoul,
			force_max_refresh = 1, force_min_refresh = 1,
			suffix = ' °', forced_min = 0,
			rangeMin = -100, rangeMax = 100
		}
	)
	table.insert( savedcols, tPoul)
	offy = offy + 75

	local grHydro = Gradient(
		{
			[80] = COL_RED,
			[70] = COL_ORANGE,
			[65] = COL_GREEN,
			[50] = COL_RED
		}
	)

	srf:DrawString("Humidité :", 310, offy)
	local srf_hPoul = FieldBlink( srf, animTimer, 315 + ftitle1:StringWidth("Humidité :"), offy + ftitle1:GetHeight() - fsdigit:GetHeight(), fsdigit, COL_DIGIT, {
		timeout = 360,
		gradient = grHydro,
		align = ALIGN_RIGHT,
		suffix = ' %',
		sample_text = "100.00 %"
	} )
	offy = offy + ftitle1:GetHeight()

	local srfg_hPoul = GfxArea( srf, 310, offy, 320, 70, COL_BLUE, COL_GFXBG,{
		heverylines={ {5, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local srf_MaxHPoul = FieldBackBorder( srf, 315, offy+5, fsdigit, COL_ORANGE, {
		align = ALIGN_RIGHT,
		keepbackground = true,
		sample_text = "100.00",
		ndecimal = 2
	} )
	local srf_MinHPoul = FieldBackBorder( srf, 315, offy + 68 - fsdigit:GetHeight(), fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		keepbackground = true,
		sample_text = "100.88",
		ndecimal = 2
	} )

	local hPoul = MQTTStoreGfx( 'hPoul', 'Poulailler/Perchoir/Humidite', srf_hPoul, srfg_hPoul, 
		{
			smax=srf_MaxHPoul, smin=srf_MinHPoul,
			force_max_refresh = 1, force_min_refresh = 1,
			suffix = ' %', forced_min = 0
		}
	)
	table.insert( savedcols, hPoul)
	offy = offy + 75

	x = 310
	y = offy + ftitle1:GetHeight()
	srf:DrawString("WiFi :", x, offy)
	local srf_WiFi = Field( srf, x + ftitle1:StringWidth("WiFi : "), offy + ftitle1:GetHeight() - fsdigit:GetHeight(), fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srfg_WiFi = GfxArea( srf, x, y, 102, 70, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	srfg_WiFi.get():FillGrandient { TopLeft={0x5d,0x07,0x07, 0xff}, BottomLeft={0x5d,0x07,0x07, 0xff}, BottomRight={0xff,0x0f,0x0f, 0xff} ,TopRight={0xff,0x0f,0x0f, 0xff} }
	srfg_WiFi.FrozeUnder()
	local WiFi = MQTTStoreGfx( 'WiFi', 'Poulailler/Wifi', srf_WiFi, srfg_WiFi, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, WiFi)

	x = x + 106
	srf:DrawString("N/A :", x, offy)
	local srf_NA = Field( srf, x + ftitle1:StringWidth("MQTT : "), offy + ftitle1:GetHeight() - fsdigit:GetHeight(), fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srfg_NA = GfxArea( srf, x, y, 102, 70, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	srfg_NA.get():FillGrandient { TopLeft={0x5d,0x07,0x07, 0xff}, BottomLeft={0x5d,0x07,0x07, 0xff}, BottomRight={0xff,0x0f,0x0f, 0xff} ,TopRight={0xff,0x0f,0x0f, 0xff} }
	srfg_NA.FrozeUnder()
	local NA = MQTTStoreGfx( 'NA', 'Poulailler/MQTT/Connection', srf_NA, srfg_NA, 
		{ forced_min = 0}
	)
--	table.insert( savedcols, NA)

	x = x + 106
	srf:DrawString("MQTT :", x, offy)
	local srf_MQTT = Field( srf, x + ftitle1:StringWidth("MQTT : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srfg_MQTT = GfxArea( srf, x, y, 102, 70, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	srfg_MQTT.get():FillGrandient { TopLeft={0x5d,0x07,0x07, 0xff}, BottomLeft={0x5d,0x07,0x07, 0xff}, BottomRight={0xff,0x0f,0x0f, 0xff} ,TopRight={0xff,0x0f,0x0f, 0xff} }
	srfg_MQTT.FrozeUnder()
	local MQTT = MQTTStoreGfx( 'MQTT', 'Poulailler/MQTT', srf_MQTT, srfg_MQTT, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, MQTT)

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Poulailler = poulailler()

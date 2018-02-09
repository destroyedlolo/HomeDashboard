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

	local szx, szy = 
		WINSIZE[1],
		(WINSIZE[2] - offy - BBh - ftitle1:GetHeight())/3

	local grTension = Gradient(
		{
			[4500] = COL_RED,
			[4600] = COL_ORANGE,
			[4900] = COL_GREEN,
			[5500] = COL_RED
		}
	)

	srf:SetFont( ftitle1 )
	srf:DrawString("Stations rép. :", 0, offy)
	srf:DrawString("Tens. Poulailler :", szx/2, offy)
	local srf_vRep = FieldBlink( srf, animTimer, 5 + ftitle1:StringWidth("Stations rép. :"), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "8"
	} )
	local srf_vPoul = FieldBlink( srf, animTimer, szx/2 + 5 + ftitle1:StringWidth("Tens. Poulailler :"), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		timeout = 360,
		gradient = grTension,
		sample_text = "3333"
	} )
	offy = offy + ftitle1:GetHeight()

	local srfg_vRep = GfxArea( srf, 0,offy, szx/2 - 5, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local vRep = MQTTStoreGfx( 'vRep', 'ESPRouter_Domo/NoStations', srf_vRep, srfg_vRep, 
		{ forced_min = 0}
	)
	table.insert( savedcols, vRep)
	local srfg_vPoul = GfxArea( srf, szx/2,offy, szx/2 - 5, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local vPoul = MQTTStoreGfx( 'vPoul', 'Poulailler/Alim', srf_vPoul, srfg_vPoul, 
		{ forced_min = 0}
	)
	table.insert( savedcols, vPoul)

	
	offy = offy + szy

	local grHydro = Gradient(
		{
			[80] = COL_RED,
			[70] = COL_ORANGE,
			[65] = COL_GREEN,
			[50] = COL_RED
		}
	)

	srf:DrawString("Hydro. Poulailler :", 0, offy)
	srf:DrawString("Temp. Poulailler :", szx/2, offy)
	local srf_hPoul = Field( srf, 5 + ftitle1:StringWidth("Hydro. Poulailler :"), offy, fsdigit, COL_DIGIT, {
		timeout = 360,
		gradient = grHydro,
		align = ALIGN_RIGHT,
		sample_text = "100.31 %"
	} )
	local srf_tPoul = Field( srf, szx/2 + 5 + ftitle1:StringWidth("Temp. Poulailler :"), offy, fsdigit, COL_DIGIT, {
		timeout = 360,
		align = ALIGN_RIGHT,
		sample_text = "20.31 °"
	} )
	offy = offy + ftitle1:GetHeight()
	local srfg_hPoul = GfxArea( srf, 0,offy, szx/2 - 5, szy, COL_BLUE, COL_GFXBG,{
		heverylines={ {15, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local hPoul = MQTTStoreGfx( 'hPoul', 'Poulailler/Perchoir/Humidite', srf_hPoul, srfg_hPoul, 
		{ xsmax=srf_maxprod, suffix = ' %', forced_min = 0}
	)
	table.insert( savedcols, hPoul)

	local srfg_tPoul = GfxArea( srf, szx/2,offy, szx/2, szy, COL_RED, COL_GFXBG,{
		heverylines={ {5, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local tPoul = MQTTStoreGfx( 'tPoul', 'Poulailler/Perchoir/Temperature', srf_tPoul, srfg_tPoul, 
		{ suffix = ' °', forced_min = 0, rangeMin = -100, rangeMax = 100 }
	)
	table.insert( savedcols, tPoul)
	offy = offy + szy

	srf:DrawString("WiFi :", 0, offy)
	srf:DrawString("N/A :", szx/3, offy)
	srf:DrawString("MQTT :", 2 * szx/3, offy)
	local srf_WiFi = Field( srf, ftitle1:StringWidth("WiFi : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srf_NA = Field( srf, szx/3 + ftitle1:StringWidth("N/A : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srf_MQTT = Field( srf, 2*szx/3 + ftitle1:StringWidth("MQTT : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	offy = offy + ftitle1:GetHeight()
	local srfg_WiFi = GfxArea( srf, 0,offy, szx/3, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local WiFi = MQTTStoreGfx( 'WiFi', 'Poulailler/Wifi', srf_WiFi, srfg_WiFi, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, WiFi)
	local srfg_NA = GfxArea( srf, szx/3,offy, szx/3, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local NA = MQTTStoreGfx( 'NA', 'Poulailler/MQTT/Connection', srf_NA, srfg_NA, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
--	table.insert( savedcols, NA)

	local srfg_MQTT = GfxArea( srf, 2*szx/3,offy, szx/3, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local MQTT = MQTTStoreGfx( 'MQTT', 'Poulailler/MQTT', srf_MQTT, srfg_MQTT, 
		{ forced_min = 0}
	)
	table.insert( savedcols, MQTT)

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Poulailler = poulailler()

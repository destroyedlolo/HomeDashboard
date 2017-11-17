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

	srf:SetFont( ftitle1 )
	srf:DrawString("Tension répéteur :", 0, offy)
	local srf_vRep = Field( srf, 5 + ftitle1:StringWidth("Tension répéteur :"), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333 mV"
	} )
	offy = offy + ftitle1:GetHeight()

	local srfg_vRep = GfxArea( srf, 0,offy, szx, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local vRep = MQTTStoreGfx( 'vRep', 'ESPRouter_Domo/Vdd', srf_vRep, srfg_vRep, 
		{ xsmax=srf_maxprod, suffix = ' mV', forced_min = 0}
	)
	table.insert( savedcols, vRep)
	offy = offy + szy

	srf:DrawString("Tens. Poulailler :", 0, offy)
	srf:DrawString("Temp. Poulailler :", szx/2, offy)
	local srf_vPoul = Field( srf, 5 + ftitle1:StringWidth("Tens. Poulailler :"), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srf_tPoul = Field( srf, szx/2 + 5 + ftitle1:StringWidth("Temp. Poulailler :"), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "20.31 °"
	} )
	offy = offy + ftitle1:GetHeight()
	local srfg_vPoul = GfxArea( srf, 0,offy, szx/2 - 5, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local vPoul = MQTTStoreGfx( 'vPoul', 'Poulailler/Alim', srf_vPoul, srfg_vPoul, 
		{ xsmax=srf_maxprod, suffix = ' mV', forced_min = 0}
	)
	table.insert( savedcols, vPoul)

	local srfg_tPoul = GfxArea( srf, szx/2,offy, szx/2, szy, COL_RED, COL_GFXBG,{
		heverylines={ {5, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local tPoul = MQTTStoreGfx( 'tPoul', 'Poulailler/TestTemp', srf_tPoul, srfg_tPoul, 
		{ xsmax=srf_maxprod, suffix = ' °', forced_min = 0}
	)
	table.insert( savedcols, tPoul)
	offy = offy + szy

	srf:DrawString("WiFi :", 0, offy)
	srf:DrawString("MQTT :", szx/3, offy)
	srf:DrawString("pub :", 2 * szx/3, offy)
	local srf_WiFi = Field( srf, ftitle1:StringWidth("WiFi : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srf_MQTT = Field( srf, szx/3 + ftitle1:StringWidth("MQTT : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srf_Pub = Field( srf, 2*szx/3 + ftitle1:StringWidth("pub : "), offy, fsdigit, COL_DIGIT, {
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
	local srfg_MQTT = GfxArea( srf, szx/3,offy, szx/3, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local MQTT = MQTTStoreGfx( 'MQTT', 'Poulailler/MQTT/Connection', srf_MQTT, srfg_MQTT, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, MQTT)
	local srfg_Pub = GfxArea( srf, 2*szx/3,offy, szx/3, szy, COL_RED, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local Pub = MQTTStoreGfx( 'Pub', 'Poulailler/MQTT', srf_Pub, srfg_Pub, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, Pub)

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Poulailler = poulailler()

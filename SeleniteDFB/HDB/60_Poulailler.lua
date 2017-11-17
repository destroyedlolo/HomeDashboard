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
			[2500] = COL_RED,
			[2600] = COL_ORANGE,
			[2900] = COL_GREEN,
			[3500] = COL_RED
		}
	)

	local srfg_vRep = GfxArea( srf, 75, 39, 126, 58, COL_GREEN, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	local srf_vRep = Field( srf, 93,103, fsdigit, COL_DIGIT, {
		timeout = 70,
		gradient = grTension,
		align = ALIGN_RIGHT,
		suffix = ' mV',
		sample_text = "3333 mV"
	} )
	local vRep = MQTTStoreGfx( 'vRep', 'ESPRouter_Domo/Vdd', srf_vRep, srfg_vRep, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, vRep)

	srf:SetFont( ftitle1 )
	srf:SetColor( COL_TITLE.get() )
	offy = 34
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
		{ xsmax=srf_maxprod, suffix = ' mV', forced_min = 0}
	)
	table.insert( savedcols, vPoul)
	offy = offy + 75

	srf:DrawString("Température :", 310, offy)
	local srf_tPoul = FieldBlink( srf, animTimer, 315 + ftitle1:StringWidth("Température :"), offy, fsdigit, COL_DIGIT, {
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

	local tPoul = MQTTStoreGfx( 'tPoul', 'Poulailler/TestTemp', srf_tPoul, srfg_tPoul, 
		{
			smax=srf_MaxTPoul, smin=srf_MinTPoul,
			force_max_refresh = 1, force_min_refresh = 1,
			suffix = ' °', forced_min = 0
		}
	)
	table.insert( savedcols, tPoul)
	offy = offy + 75

	x = 310
	y = offy + ftitle1:GetHeight()
	srf:DrawString("WiFi :", x, offy)
	local srf_WiFi = Field( srf, x + ftitle1:StringWidth("WiFi : "), offy, fsdigit, COL_DIGIT, {
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
	local MQTT = MQTTStoreGfx( 'MQTT', 'Poulailler/MQTT/Connection', srf_MQTT, srfg_MQTT, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, MQTT)

	x = x + 106
	srf:DrawString("Pub :", x, offy)
	local srf_Pub = Field( srf, x + ftitle1:StringWidth("Pub : "), offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "3333"
	} )
	local srfg_Pub = GfxArea( srf, x, y, 102, 70, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	srfg_Pub.get():FillGrandient { TopLeft={0x5d,0x07,0x07, 0xff}, BottomLeft={0x5d,0x07,0x07, 0xff}, BottomRight={0xff,0x0f,0x0f, 0xff} ,TopRight={0xff,0x0f,0x0f, 0xff} }
	srfg_Pub.FrozeUnder()
	local Pub = MQTTStoreGfx( 'Pub', 'Poulailler/MQTT', srf_Pub, srfg_Pub, 
		{ xsmax=srf_maxprod, forced_min = 0}
	)
	table.insert( savedcols, Pub)

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Poulailler = poulailler()

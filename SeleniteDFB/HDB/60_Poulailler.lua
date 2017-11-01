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
			[2800] = COL_ORANGE,
			[3000] = COL_GREEN,
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
	local srf_vPoul = FieldBlink( srf, animTimer, 315 + ftitle1:StringWidth("Alimentation :"), offy, fsdigit, COL_DIGIT, {
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
	local srf_MaxTPool = FieldBackBorder( srf, 315, offy+5, fsdigit, COL_ORANGE, {
		align = ALIGN_RIGHT,
		keepbackground = true,
		sample_text = "-88.88",
		ndecimal = 2
	} )
	local srf_MinTPool = FieldBackBorder( srf, 315, offy + 68 - fsdigit:GetHeight(), fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		keepbackground = true,
		sample_text = "-88.88",
		ndecimal = 2
	} )

	local tPoul = MQTTStoreGfx( 'tPoul', 'Poulailler/2882b25e09000015', srf_tPoul, srfg_tPoul, 
		{
			smax=srf_MaxTPool, smin=srf_MinTPool,
			force_max_refresh = 1, force_min_refresh = 1,
			suffix = ' °', forced_min = 0
		}
	)
	table.insert( savedcols, tPoul)
	offy = offy + 75

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Poulailler = poulailler()

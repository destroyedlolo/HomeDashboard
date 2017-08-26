-- Internet figures

local function internetfg()
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
	srf:DrawString("Internet", 0, 0)
	local offy = ftitle:GetHeight()

	local szx, szy = 
		WINSIZE[1],
		(WINSIZE[2] - offy - BBh - ftitle1:GetHeight())/3

	srf:SetFont( ftitle1 )
	srf:DrawString("FEC :", 0, offy)
	offy = offy + ftitle1:GetHeight()

	local srf_FEC = GfxArea( srf, 0,offy, szx, szy, COL_RED, COL_GFXBG,{
		mode = 'delta',
		heverylines={ {100, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
--	srf_FEC.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }

	local maxFECu = FieldBackBorder( srf, 2, offy+2, fsdigit, COL_DIGIT, {
		keepbackground = true,
		align = ALIGN_RIGHT,
		sample_text = "12345"
	} )

	local FECu = MQTTStoreGfx( 'FECu', 'Freebox/UploadFEC', nil, srf_FEC,
		{
			forced_min = 0,
			smax = maxTConso,
			force_max_refresh = true,
			group = 300
		}
	)
	table.insert( savedcols, FECu )
	offy = offy + szy

	srf:SetFont( ftitle1 )
	srf:DrawString("CRC :", 0, offy)
	offy = offy + ftitle1:GetHeight()

	local srf_CRC = GfxArea( srf, 0,offy, szx, szy, COL_RED, COL_GFXBG,{
		mode = 'delta',
		heverylines={ {100, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
--	srf_CRC.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }

	local maxCRCu = FieldBackBorder( srf, 2, offy+2, fsdigit, COL_DIGIT, {
		keepbackground = true,
		align = ALIGN_RIGHT,
		sample_text = "12345"
	} )

	local CRCu = MQTTStoreGfx( 'CRCu', 'Freebox/UploadCRC', nil, srf_FEC,
		{
			forced_min = 0,
			smax = maxTConso,
			force_max_refresh = true,
			group = 300
		}
	)
	table.insert( savedcols, CRCu )
	offy = offy + szy

	srf:SetFont( ftitle1 )
	srf:DrawString("HEC :", 0, offy)
	offy = offy + ftitle1:GetHeight()

	local srf_HEC = GfxArea( srf, 0,offy, szx, szy, COL_RED, COL_GFXBG,{
		mode = 'delta',
		heverylines={ {100, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
--	srf_HEC.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }

	local maxHECu = FieldBackBorder( srf, 2, offy+2, fsdigit, COL_DIGIT, {
		keepbackground = true,
		align = ALIGN_RIGHT,
		sample_text = "12345"
	} )

	local HECu = MQTTStoreGfx( 'HECu', 'Freebox/UploadHEC', nil, srf_FEC,
		{
			forced_min = 0,
			smax = maxTConso,
			force_max_refresh = true,
			group = 300
		}
	)
	table.insert( savedcols, HECu )

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

InterFG = internetfg()

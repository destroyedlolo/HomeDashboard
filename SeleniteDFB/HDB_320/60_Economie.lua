-- Energy saving
local function energy()
	local self = {}

	local window = layer:CreateWindow {
		pos = WINTOP, size = WINSIZE,
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE'),
	}
	window:SetOpacity(0xff)	-- Make the window visible
	table.insert( winlist, window )
	local srf = window:GetSurface()

	srf:SetColor( COL_TITLE.get() )
	srf:SetFont( ftitle )
	srf:DrawString("Economies d'énergie", 0, 0)

	cdt = MQTTCounterStatGfx(srf,
		'Stat mensuelle', 'Domestik/Electricite/Mensuel', 
		5, ftitle:GetHeight()+5, 200,100, {
			bordercolor = COL_GREY ,
			consumption_border = COL_ORANGED,
			xproduction_border = COL_GREEND,
			maxyears = 3,
			fadeyears = 20,
			barrespace = 0,
			yearXoffset = 3,
			production_offset = 2
		} 
	)

	local x, y = cdt.get():GetBelow()
	y = y + 2
	local srf_ctrndconso = GfxArea( srf, x,y, 98, 48, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT
	} )
	srf_ctrndconso.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }
	srf_ctrndconso.FrozeUnder()

	local maxTConso = FieldBackBorder( srf, x+2, y+2, fsdigit, COL_DIGIT, {
		keepbackground = true,
		align = ALIGN_RIGHT,
		sample_text = "12345"
	} )

	local conso2 = MQTTStoreGfx( 'consomation2', 'TeleInfo/Consommation/values/PAPP', nil, srf_ctrndconso, 
		{
			forced_min = 0,
			smax = maxTConso,
			force_max_refresh = true,
			group = 6*60*60 / srf_ctrndconso.get():GetWidth()	-- 6h retention
		}
	)
	table.insert( savedcols, conso2 )

	local srf_ctrndprod = GfxArea( srf, x+102, y, 98, 48, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	srf_ctrndprod.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }
	srf_ctrndprod.FrozeUnder()

	local maxTProd= FieldBackBorder( srf, x+104, y+2, fsdigit, COL_DIGIT, {
		keepbackground = true,
		align = ALIGN_RIGHT,
		sample_text = "12345"
	} )

	local prod2 = MQTTStoreGfx( 'production2', 'TeleInfo/Production/values/PAPP', nil, srf_ctrndprod, 
		{
			smax = maxTProd,
			force_max_refresh = true,
			forced_min = 0,
			group = 6*60*60 / srf_ctrndprod.get():GetWidth()	-- 6h retention
		}
	)
	table.insert( savedcols, prod2 )

	SelLog.log("*I* Consummation / Production grouped by ".. 6*60*60 / srf_ctrndconso.get():GetWidth())
	return self
end

Energy = energy()

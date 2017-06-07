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
	srf:DrawString("Econnomies d'énergie", 0, 0)

	cdt = MQTTCounterStatGfx(srf,
		'Stat mensuelle', 'Domestik/Electricite/Mensuel', 
		95, ftitle:GetHeight()+10, 425,260, {
			bordercolor = COL_GREY ,
			consumption_border = COL_ORANGED,
			production_border = COL_GREEND,
			maxyears = 3,
			fadeyears = 25,
		} 
	)

	local x, y = cdt.get():GetBelow()
	x = 20
	y = y+15
	srf:SetColor( COL_TITLE.get() )
	srf:SetFont( ftitle1 )
	srf:DrawString("Consommation", x,y)
	srf:DrawString("Production", x + (WINSIZE[1]-x)/2,y)
	y = y+ftitle1:GetHeight()

	local srf_ctrndconso = GfxArea( srf, x,y, (WINSIZE[1]-x)/2-20, WINSIZE[2] -y-15, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	srf_ctrndconso.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }
	srf_ctrndconso.FrozeUnder()

	local conso2 = MQTTStoreGfx( 'consomation2', 'TeleInfo/Consommation/values/PAPP', nil, srf_ctrndconso, 
		{
			forced_min = 0,
			group = 12*60*60 / srf_ctrndconso.get():GetWidth()	-- 12h retention
		}
	)
	table.insert( savedcols, conso2 )

	local srf_ctrndprod = GfxArea( srf, x + (WINSIZE[1]-x)/2,y, (WINSIZE[1]-x)/2-20, WINSIZE[2] -y-15, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )
	srf_ctrndprod.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }
	srf_ctrndprod.FrozeUnder()

	local prod2 = MQTTStoreGfx( 'production2', 'TeleInfo/Production/values/PAPP', nil, srf_ctrndprod, 
		{
			forced_min = 0,
			group = 12*60*60 / srf_ctrndprod.get():GetWidth()	-- 12h retention
		}
	)
	table.insert( savedcols, prod2 )

	SelLog.log("*I* Consummation / Production grouped by ".. 12*60*60 / srf_ctrndprod.get():GetWidth())

	return self
end

Energy = energy()

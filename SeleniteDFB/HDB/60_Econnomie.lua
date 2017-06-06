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
		95, ftitle:GetHeight()+40, 425,250, {
			bordercolor = COL_GREY ,
			consumption_border = COL_ORANGED,
			production_border = COL_GREEND,
			maxyears = 3,
			fadeyears = 25,
		} 
	)

	local x, y = cdt.get():GetBelow()
	x = x-20
	y = y+20

	local srf_ctrndconso = GfxArea( srf, x,y, (WINSIZE[1]-x)/2-20, WINSIZE[2] -y-15, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		align=ALIGN_RIGHT 
	} )
	srf_ctrndconso.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }
	srf_ctrndconso.FrozeUnder()

	local conso2 = MQTTStoreGfx( 'consomation2', 'TeleInfo/Consommation/values/PAPP', nil, srf_ctrndconso, 
		{
			forced_min = 0,
			group = srf_ctrndconso.get():GetWidth()/12*60*60	-- 12h retention
		}
	)
	table.insert( savedcols, conso2 )

	return self
end

Energy = energy()

-- 1st floor

local function upstaire()
	local self = {}
	local x,y 

	local window = layer:CreateWindow {
		pos = WINTOP, size = WINSIZE,
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	}
	window:SetOpacity(0xff)	-- Make the window visible
	table.insert( winlist, window )
	local srf = window:GetSurface()

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/1er.png")
	assert(img)
	local x,y = img:GetSize()
	local s = (WINSIZE[1] - 60 ) / x
	img:RenderTo( srf, { 30, WINSIZE[2] - y*s - 20, x*s, y*s } )
	img:destroy()	-- The image is not needed anymore
print(WINSIZE[2] - y*s)

	x,y = 35, 150
	srf:SetColor( COL_TITLE.get() )
	srf:SetFont( ftitle1 )
	srf:DrawString("Grenier Nord", x, y)
	s = ftitle1:StringWidth("Grenier Nord")
	y = y + ftitle1:GetHeight()

	srf_TGN = FieldBlink( srf, animTimer,
		x + s - fmdigit:StringWidth("°C"), y, fmdigit, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8"
	})
	srf:SetFont( fmdigit )
	srf:DrawString("°C", srf_TGN.get():GetAfter() )
	_,y = srf_TGN.get():GetBellow()

	local srf_TGNgfx = GfxArea( srf, x, y, s, HSGRPH, COL_TRANSPARENT, COL_GFXBG, { align=ALIGN_RIGHT } )
	srf_TGNgfx.get():FillGrandient { TopLeft={20,20,20,255}, BottomLeft={20,20,20,255}, TopRight={255,100,32,255}, BottomRight={32,255,32,255} }
	srf_TGNgfx.FrozeUnder()

	local TGN_dt = MQTTStoreGfx( 'TGN', 'maison/Temperature/Grenier Nord', srf_TGN, srf_TGNgfx, 
		{
			gradient = GRD_TEMPERATURE,
--			forced_min = 0,
		}
	)

		-- refresh window's content
	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Upstaire = upstaire()


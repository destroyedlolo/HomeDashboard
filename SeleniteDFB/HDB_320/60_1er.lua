local function upstaire()
	local self = {}

	local window = layer:CreateWindow {
		pos = WINTOP, size = WINSIZE,
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	}
	window:SetOpacity(0xff)	-- Make the window visible
	table.insert( winlist, window )
	local srf = window:GetSurface()

	srf:SetColor( COL_TITLE.get() )
	srf:SetFont( ftitle )
	srf:DrawString("Premier étage", 0, 0)

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/1er.png")
	assert(img)
	local x,y = img:GetSize()
	local s = (WINSIZE[1] - 20 ) / x
	img:RenderTo( srf, { 10, WINSIZE[2] - y*s - 10, x*s, y*s } )
	img:destroy()	-- The image is not needed anymore

	local tgn = MinorTempArea( srf, 'TGN', 'maison/Temperature/Grenier Nord', 0,80,
		{
			font = fmdigit,
			title = "Gr Nord"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tgn.getAfter()+3, 80, tgn.getAfter()+3, 155 )

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Upstaire = upstaire()


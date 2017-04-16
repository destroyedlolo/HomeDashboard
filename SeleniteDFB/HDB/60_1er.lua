-- 1st floor

local function upstaire()
	local self = {}
	local x,y 

	local window = layer:CreateWindow {
		pos = WINTOP, size = WINSIZE,
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE'),
		pixelformat=SelSurface.PixelFormatConst('ARGB')
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
	local s = (WINSIZE[1] - 60 ) / x
	img:RenderTo( srf, { 30, WINSIZE[2] - y*s - 20, x*s, y*s } )
	img:destroy()	-- The image is not needed anymore

	PorteGS = Porte( srf, 'PorteGS', 'maison/IO/Porte_GSud', x*s - 150, WINSIZE[2] - y*s + 10 )

	MintorTempArea( srf, 'TGN', 'maison/Temperature/Grenier Nord', 35,150,
		{
			font = fmdigit,
			title = "Grenier Nord"
		}
	)

	MintorTempArea( srf, 'TGS', 'maison/Temperature/Grenier Sud', 535,150,
		{
			font = fmdigit,
			title = "Grenier Sud"
		}
	)

	MintorTempArea( srf, 'TCJ', 'maison/Temperature/Chambre Joris', 140,50,
		{
			font = fdigit,
			title = "Chambre Joris"
		}
	)

	MintorTempArea( srf, 'TCP', 'maison/Temperature/Chambre Parents', 255,30,
		{
			font = fdigit,
			title = "Chambre Parents"
		}
	)

	MintorTempArea( srf, 'TCO', 'maison/Temperature/Chambre Oceane', 390,50,
		{
			font = fdigit,
			title = "Chambre Océane"
		}
	)

	MintorTempArea( srf, 'TComble', 'maison/Temperature/Comble', 535,0,
		{
			font = fmdigit,
			title = "Comble",
			size = 80
		}
	)

		-- refresh window's content
	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Upstaire = upstaire()


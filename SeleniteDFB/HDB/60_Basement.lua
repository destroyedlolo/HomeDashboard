-- Basement

local function basement()
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
	srf:DrawString("Sous-sol", 0, 0)

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/SousSol.png")
	assert(img)
	local x,y = img:GetSize()
	local s = (WINSIZE[1] - 60 ) / x
	img:RenderTo( srf, { 30, WINSIZE[2] - y*s - 20, x*s, y*s } )
	img:destroy()	-- The image is not needed anymore


	local tSSporte = MinorTempArea( srf, 'TSSPorte', 'maison/Temperature/GarageP', 35,150,
		{
			font = fdigit,
			title = "Porte Sous-Sol"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tSSporte.getAfter()+5, 170, tSSporte.getAfter()+5, 350 )

	MinorTempArea( srf, 'TSS', 'maison/Temperature/Garage', 535,150,
		{
			font = fdigit,
			title = "Sous-Sol",
			size = fdigit:StringWidth("88.8°C")
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 530, 170, 530, 350 )

	MinorTempArea( srf, 'TCongelo', 'maison/Temperature/Congelateur', 490,30,
		{
			font = fmdigit,
			title = "Congélateur",
			size = 80
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 485, 50, 485, 260 )

		-- refresh window's content
	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Basement = basement()


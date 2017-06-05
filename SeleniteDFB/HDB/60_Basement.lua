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

--	img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/bPI.png")

	Porte( srf, 'PorteGarage', 'maison/IO/Porte_Garage', 60, 320 )
	Porte( srf, 'PorteCave', 'maison/IO/Porte_Cave', 350, 235 )

	local tcvin = MinorTempArea( srf, 'TCVin', 'maison/Temperature/Cave Vin', 350,40,
		{
			font = fdigit,
			min_delta = 0.75,
			size = fdigit:StringWidth("88.8°C"), 
			title = "Cave a vin"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tcvin.getAfter()+5, 60, tcvin.getAfter()+5, 250 )

	local tSSporte = MinorTempArea( srf, 'TSSPorte', 'maison/Temperature/GarageP', 35,150,
		{
			font = fdigit,
			min_delta = 0.75,
			title = "Porte Sous-Sol"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tSSporte.getAfter()+5, 170, tSSporte.getAfter()+5, 350 )

	MinorTempArea( srf, 'TSS', 'maison/Temperature/Garage', 535,150,
		{
			font = fdigit,
			title = "Sous-Sol",
			min_delta = 0.75,
			size = fdigit:StringWidth("88.8°C")
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 530, 170, 530, 350 )

	MinorTempArea( srf, 'TCongelo', 'maison/Temperature/Congelateur', 490,30,
		{
			font = fmdigit,
			gradient = Gradient(
				{
					[-19] = COL_DIGIT,
					[-16] = COL_GREEN,
					[-12] = COL_ORANGE,
					[-10] = COL_RED
				}
			),
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


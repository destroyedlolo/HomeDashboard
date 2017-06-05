-- 1st floor

local function upstaire()
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
	srf:DrawString("Premier étage", 0, 0)

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/1er.png")
	assert(img)
	local x,y = img:GetSize()
	local s = (WINSIZE[1] - 60 ) / x
	img:RenderTo( srf, { 30, WINSIZE[2] - y*s - 20, x*s, y*s } )
	img:destroy()	-- The image is not needed anymore

	PorteGS = Porte( srf, 'PorteGS', 'maison/IO/Porte_GSud', x*s - 150, WINSIZE[2] - y*s + 10 )
	PorteGN = Porte( srf, 'PorteGN', 'maison/IO/Porte_GNord', 160, WINSIZE[2] - y*s + 10 )

	local tgn = MinorTempArea( srf, 'TGN', 'maison/Temperature/Grenier Nord', 35,150,
		{
			font = fmdigit,
			title = "Grenier Nord",
			min_delta = 0.75
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tgn.getAfter()+5, 170, tgn.getAfter()+5, 350 )

	MinorTempArea( srf, 'TGS', 'maison/Temperature/Grenier Sud', 535,150,
		{
			font = fmdigit,
			title = "Grenier Sud",
			min_delta = 0.75
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 530, 170, 530, 350 )

	local tcj = RoomArea( srf, 'TCJ', 'maison/Temperature/Chambre Joris', 135,50,
		'Majordome/Mode/Joris',
		'Majordome/HLever/Joris',
		{
			font = fdigit,
			title = "Chambre Joris",
			min_delta = 0.75
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tcj.getAfter()+5 , 70, tcj.getAfter()+5, 350 )

	local tcp = RoomArea( srf, 'TCP', 'maison/Temperature/Chambre Parents', 247,30,
		'Majordome/Mode/Parents',
		'Majordome/HLever',
		{
			font = fdigit,
			title = "Chambre Parents",
			min_delta = 0.75
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tcp.getAfter()+5 , 50, tcp.getAfter()+5, 270 )

	RoomArea( srf, 'TCO', 'maison/Temperature/Chambre Oceane', 390,50,
		'Majordome/Mode/Oceane',
		'Majordome/HLever/Oceane',
		{
			font = fdigit,
			title = "Chambre Océane",
			min_delta = 0.75
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 385, 70, 385, 350 )

	MinorTempArea( srf, 'TComble', 'maison/Temperature/Comble', 535,0,
		{
			font = fmdigit,
			title = "Comble",
			size = 80,
			min_delta = 0.75
		}
	)

		-- refresh window's content
	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Upstaire = upstaire()


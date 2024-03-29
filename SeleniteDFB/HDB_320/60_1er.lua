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

	PorteGS = Porte( srf, 'PorteGS', 'maison/IO/Porte_GSud', x*s - 55, WINSIZE[2] - y*s, { width=14, hight=23 } )
	PorteGN = Porte( srf, 'PorteGN', 'maison/IO/Porte_GNord', 57, WINSIZE[2] - y*s, { width=14, hight=23 })

	local tgn = MinorTempArea( srf, 'TGN', 'maison/Temperature/Grenier Nord', 0,85,
		{
			font = fmdigit,
			title = "Gr Nord",
			min_delta = 1
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tgn.getAfter()+3, 87, tgn.getAfter()+3, 155 )

	local tcj = RoomArea( srf, 'TCJ', 'maison/Temperature/Chambre Joris', 45,40,
		'Majordome/Mode/Joris',
		'Majordome/HLever/Joris',
		{
			font = fmdigit,
			title = "Ch Joris",
			min_delta = 0.75
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tcj.getAfter()+2 , 43, tcj.getAfter()+2, 160 )

	local tca = RoomArea( srf, 'TCA', 'maison/Temperature/Chambre Amis', 85,25,
		'Majordome/Mode/ChAmis',
		'Majordome/HLever/ChAmis',
		{
			font = fmdigit,
			title = "Amis",
			min_delta = 0.75
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tca.getAfter()+2 , 28, tca.getAfter()+2, 130 )

	RoomArea( srf, 'TCO', 'maison/Temperature/Chambre Oceane', 128,40,
		'Majordome/Mode/Oceane',
		'Majordome/HLever/Oceane',
		{
			font = fmdigit,
			title = "Océane",
			min_delta = 0.75
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 125, 43, 125, 160 )

	MinorTempArea( srf, 'TGS', 'maison/Temperature/Grenier Sud', 168,75,
		{
			font = fmdigit,
			title = "Gr. Sud",
			min_delta = 1
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 166, 78, 166, 155 )

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Upstaire = upstaire()


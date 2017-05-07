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

	local tgn = MinorTempArea( srf, 'TGN', 'maison/Temperature/Grenier Nord', 0,85,
		{
			font = fmdigit,
			title = "Gr Nord"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tgn.getAfter()+2, 87, tgn.getAfter()+3, 155 )

	local tcj = RoomArea( srf, 'TCJ', 'maison/Temperature/Chambre Joris', 45,40,
		'Majordome/Mode/Joris',
		'Majordome/HLever/Joris',
		{
			font = fmdigit,
			title = "Ch Joris"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tcj.getAfter()+2 , 43, tcj.getAfter()+2, 160 )

	local tcp = RoomArea( srf, 'TCP', 'maison/Temperature/Chambre Parents', 85,25,
		'Majordome/Mode/Parents',
		'Majordome/HLever',
		{
			font = fmdigit,
			title = "Parents"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tcp.getAfter()+2 , 28, tcp.getAfter()+2, 130 )

	RoomArea( srf, 'TCO', 'maison/Temperature/Chambre Oceane', 126,40,
		'Majordome/Mode/Oceane',
		'Majordome/HLever/Oceane',
		{
			font = fmdigit,
			title = "Océane"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 123, 43, 123, 160 )

	MinorTempArea( srf, 'TGS', 'maison/Temperature/Grenier Sud', 165,75,
		{
			font = fmdigit,
			title = "Gr. Sud"
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( 163, 78, 163, 155 )

	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Upstaire = upstaire()


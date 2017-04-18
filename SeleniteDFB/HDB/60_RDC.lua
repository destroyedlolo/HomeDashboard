-- Ground

local function ground()
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
	srf:DrawString("Rez de chaussée", 0, 0)

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/RDC.png")
	assert(img)
	local x,y = img:GetSize()
	local s = (WINSIZE[1] - 60 ) / x
	img:RenderTo( srf, { 30, WINSIZE[2] - y*s - 20, x*s, y*s } )
	img:destroy()	-- The image is not needed anymore


	local tbureau = MinorTempArea( srf, 'TBureau', 'maison/Temperature/Bureau', 35,150,
		{
			font = fdigit,
			title = "Bureau",
			size = fdigit:StringWidth("88.8°C")
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tbureau.getAfter()+5, 170, tbureau.getAfter()+5, 350 )

	local tsalon = MinorTempArea( srf, 'TSalon', 'maison/Temperature/Salon', 145,50,
		{
			font = fdigit,
			title = "Salon",
			size = fdigit:StringWidth("88.8°C")
		}
	)
	srf:SetColor( COL_WHITE.get() )
	srf:DrawLine( tsalon.getAfter()+5 , 70, tsalon.getAfter()+5, 350 )


		-- refresh window's content
	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Ground = ground()


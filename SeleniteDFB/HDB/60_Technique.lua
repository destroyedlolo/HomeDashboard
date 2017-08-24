-- Technical informations

local function tech()
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
	srf:DrawString("Automatismes", 0, 0)

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .."/Images/Marcel.png")
	assert(img)
	local w,h = img:GetSize()
	img:RenderTo( srf, { WINSIZE[1]/2 - w/5 - 30 , 0, w/5,h/5 } )
	img:destroy()
	local offx
	local offy = h/5

	img,err = SelImage.create(SELENE_SCRIPT_DIR .."/Images/Majordome.png")
	assert(img)
	w,h = img:GetSize()
	_ = h/offy
	img:RenderTo( srf, { WINSIZE[1]/2 + w/2/_ + 30, 0, w/_, h/_ } )
	img:destroy()
	offy = ftitle:GetHeight() + 5

	local MarcelTxt = NotificationArea( srf, 20, offy, WINSIZE[1]/2 - 40, 250, fmtxt, COL_LIGHTGREY, { bgcolor=COL_GFXBG } )
	local MarcelLog = MQTTLog('marcelW', 'Marcel.prod/Log/Warning', MarcelTxt, { udata=1 } )
	MarcelLog.RegisterTopic( 'marcelE', 'Marcel.prod/Log/Error', { udata=3 } )
	MarcelLog.RegisterTopic( 'marcelF', 'Marcel.prod/Log/Fatal', { udata=4 } )
	MarcelTxt.Log("Marcel")

	local MajordomeTxt = NotificationArea( srf, WINSIZE[1]/2 + 20, offy, WINSIZE[1]/2 - 40, 250, fmtxt, COL_LIGHTGREY, { bgcolor=COL_GFXBG } )
	local MajordomeLog = MQTTLog('Majordome', 'Majordome/Log', MajordomeTxt, { udata=1 } )
	MajordomeLog.RegisterTopic( 'MajordomeM', 'Majordome/Log/Mode', { udata=2 } )
	MajordomeLog.RegisterTopic( 'MajordomeE', 'Majordome/Log/Erreur', { udata=3 } )
	MajordomeLog.RegisterTopic( 'MajordomeA', 'Majordome/Log/Action', { udata=5 } )
	MajordomeTxt.Log("Majordome")

	offx, offy = MarcelTxt.get():GetBelow()
	offy = offy + 10
	srf:SetFont( ftitle1 )
	srf:DrawString("CRC", offx,offy)

--	local CRCu = 

		-- refresh window's content
	srf:Flip(SelSurface.FlipFlagsConst("NONE"))

	return self
end

Technical = tech()

-- Display smart home information

local function automatisme()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h, 
		{
			keepcontent = true
		}
	)

	local mainframe,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Mainframe.png")
	if not mainframe then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end
	local MajordomeImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Majordome.png")
	if not MajordomeImg then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear()
		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.setColor( COL_TITLE )
		self.setFont( fonts.title )
		self.get():DrawStringTop("Automatismes :", 5,0 )
		self.get():Blit(mainframe, 20,50)
		self.get():Blit(MajordomeImg, 535,84)
	end

	self.Clear()

	local MajordomeTxt = NotificationArea( self, WINSIZE.w - 245, 10, 245, 205, fonts.stxt, COL_LIGHTGREY, 
		{ 
			bgcolor=COL_TRANSPARENT60,
			transparency=true,
			ownsurface=true,
			timeformat='%X',
			timefont=fonts.xstxt,
			timecolor=COL_WHITE,
		} )
	local MajordomeLog = MQTTLog('Majordome', 'Majordome/Log', MajordomeTxt, { udata=-1 } )
	MajordomeLog.RegisterTopic( 'Majordome', 'Majordome/Log/Mode', { udata=2 } )
	MajordomeLog.RegisterTopic( 'Majordome', 'Majordome/Log/Erreur', { udata=3 } )
	MajordomeLog.RegisterTopic( 'Majordome', 'Majordome/Log/Action', { udata=5 } )
	MajordomeTxt.Log("Majordome")


	self.Visibility(false)
	return self
end

Automatisme = automatisme()

table.insert( winlist, Automatisme )

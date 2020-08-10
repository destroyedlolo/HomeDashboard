-- Display smart home information

local function automatisme()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h, 
		{
			keepcontent = true
		}
	)

	local mainframe,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Automatismes.png")
	if not mainframe then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear( 
		clipped -- clipping area from child (optional)
	)
		self.get():SaveContext()
		if clipped then
			self.get():SetClipS( unpack(clipped) )
		end

		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.setColor( COL_TITLE )
		self.setFont( fonts.title )
		self.get():DrawStringTop("Automatismes :", 5,0 )
		self.get():Blit(mainframe, 20,50)

		self.get():RestoreContext()
	end

	self.Clear()

	local MarcelTxt = NotificationArea( self, WINSIZE.w - 245, 230, 245, 200, fonts.stxt, COL_LIGHTGREY, 
		{ 
			bgcolor=COL_TRANSPARENT60,
			transparency=true,
			ownsurface=true,
			timeformat='%X',
			timefont=fonts.xstxt,
			timecolor=COL_WHITE,
		} )
	 local MarcelLog = MQTTLog('marcel', MARCEL ..'/Log/Warning', MarcelTxt, { udata=1 } )
	MarcelLog.RegisterTopic('marcel', MARCEL ..'/Log/Information', { udata=-1 } )
	MarcelLog.RegisterTopic( 'marcel', MARCEL ..'/Log/Error', { udata=3 } )
	MarcelLog.RegisterTopic( 'marcel', MARCEL ..'/Log/Fatal', { udata=4 } )
	MarcelTxt.Log("Marcel")

	local MajordomeTxt = NotificationArea( self, WINSIZE.w - 245, 10, 245, 205, fonts.stxt, COL_LIGHTGREY, 
		{ 
			bgcolor=COL_TRANSPARENT60,
			transparency=true,
			ownsurface=true,
			timeformat='%X',
			timefont=fonts.xstxt,
			timecolor=COL_WHITE,
		} )
	local MajordomeLog = MQTTLog('Majordome', MAJORDOME ..'/Log/Config', MajordomeTxt, { udata=1 } )
	MajordomeLog.RegisterTopic( 'Majordome', MAJORDOME ..'/Log/Information', { udata=-1 } )
	MajordomeLog.RegisterTopic( 'Majordome', MAJORDOME ..'/Log/Mode', { udata=2 } )
	MajordomeLog.RegisterTopic( 'Majordome', MAJORDOME ..'/Log/Fatal', { udata=3 } )
	MajordomeLog.RegisterTopic( 'Majordome', MAJORDOME ..'/Log/Erreur', { udata=3 } )
	MajordomeLog.RegisterTopic( 'Majordome', MAJORDOME ..'/Log/Warning', { udata=3 } )
	MajordomeLog.RegisterTopic( 'Majordome', MAJORDOME ..'/Log/Action', { udata=5 } )
	MajordomeTxt.Log("Majordome")

	self.Visibility(false)
	return self
end

Automatisme = automatisme()

--table.insert( winlist, Automatisme )

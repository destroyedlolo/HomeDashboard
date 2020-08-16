-- Display running machine statistics

local function machines()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h, 
		{
			keepcontent = true
		}
	)

	----
	-- Additional graphics
	----

	local motherboard,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Motherboard.png")
	if not motherboard then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	local MajordomeImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Majordome.png")
	if not MajordomeImg then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	local MarcelImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Marcel.png")
	if not MarcelImg then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear(
		clipped -- Clipping region
	)
		-- Restrict drawing area
		if clipped then	-- Offset this surface
			self.get():SaveContext()
			self.get():SetClipS( unpack(clipped) )
		end
	
		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.setColor( COL_TITLE )
		self.setFont( fonts.title )
		self.get():DrawStringTop("Machines :", 5,0 )
		self.get():Blit(motherboard, 50,50)

		local ix = MajordomeImg:GetSize()
		self.get():Blit(MajordomeImg, WINSIZE.w-ix,10)

		if clipped then
			self.get():RestoreContext()
		end
	end

	self.Clear()

	local machines = {}
	MachinesCollection(machines, 8)

	for i=0,8 do
		machines[i] = Machine(
			self, 
			5 + 215*(i%3), 45 + 128*math.floor(i/3), 
			200,105, 
			fonts.sdigit, COL_TITLE,
			{
				timeout = 150
			}
		)
	end

	local MajordomeTxt = NotificationArea( 
		self, 
		WINSIZE.w - 405, 0, 405, 275, fonts.stxt, COL_LIGHTGREY, 
		{ 
			bgcolor=COL_TRANSPARENT60,
			transparency=true,
			ownsurface=true,
			timeformat='%X',
			timefont=fonts.xstxt,
			timecolor=COL_WHITE,
		} 
	)
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

Machines = machines()

table.insert( winlist, Machines )

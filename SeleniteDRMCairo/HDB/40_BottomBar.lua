local function f()
	local self = Surface( psrf, LBw, psrf:GetHight()-BBh, psrf:GetWidth() - LBw, BBh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	local fond,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/BarreBas.png")
	if not fond then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear( 
		clipped -- clipping area from child (optional)
	)
		-- notez-bien : full redrawing is not needed (yet ?) as this
		-- bar is ALWAYS displayed
		self.get():SaveContext()
		if clipped then
			self.get():SetClipS( unpack(clipped) )
		end

		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.get():Blit(fond, 0,0)	-- Notez-bien : translation is also scaled
		self.get():RestoreContext()
	end
	self.Clear() -- clean the surface before displaying

	local offx,offy = 109,51
	local lvdonotif = ImageFiltreSurface( self, offx,offy+24, SELENE_SCRIPT_DIR .. "/Images/Mail.png" )
	condition_lvdo = Condition( lvdonotif, 0 )
	local poolnotif = ImageFiltreSurface( self, offx,offy, SELENE_SCRIPT_DIR .. "/Images/Piscine.png" )
	condition_pool = Condition( poolnotif, 0, {
		ok_color = COL_DARKGREEN,
		issue_color = COL_DARKRED
	} )
	offx = offx + 24

	local network = ImageFiltreSurface( self, offx,offy+24, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25, { issue_color=COL_RED } )
	table.insert( additionnalevents, condition_network.getTimer() )

	local freeboxicn = ImageFiltreSurface( self, offx,offy, SELENE_SCRIPT_DIR .. "/Images/FreeboxL.png" )
	condition_freebox = Condition(freeboxicn, .5, { autorecover=true, issue_color=COL_RED } )
	table.insert( additionnalevents, condition_freebox.getTimer() )
	offx = offx + 24

	local WiFi = ImageFiltreSurface( self, offx,offy+24, SELENE_SCRIPT_DIR .. "/Images/WiFi.png" )
	condition_WiFi = Condition(WiFi, .5, { autorecover=true, issue_color=COL_RED } )
	table.insert( additionnalevents, condition_WiFi.getTimer() )
	local WiFiNoStations = MQTTinput('WiFiNoStations', 'ESPRouter_Domo/NoStations', nil, { condition=condition_WiFi, watchdog=wdWiFi } )

	local barriere = ImageFiltreSurface( self, offx,offy, SELENE_SCRIPT_DIR .. "/Images/BarrierePoule.png" )
	condition_BarrierePoule = Condition( barriere, 0, {issue_color=COL_RED } )
	offx = offx + 24

	Notification = NotificationArea( self, 810, 31, sw-820, sh-31, fonts.xstxt, COL_DARKGREEN, { bgcolor=COL_GFXBG } )
	local log = MQTTLog('messages', 'messages', Notification, { udata=-1 } )
	log.RegisterTopic('messages', 'messages/Erreur', { udata=3 } )
	offx = offx + 200

	Saison( self, 'Saison', MAJORDOME ..'/Saison', 273, 46 )
	Saison( self, 'PSaison', MAJORDOME ..'/Saison/Hier', 235, 60, 
		{ width=35, hight=35, autoscale=true } 
	)

	Mode( self, 'Mode', MAJORDOME ..'/Mode', 437, 46 )
	Mode( self, 'ModeDemain', 'Majordome/Mode/Demain', 487, 60, 
		{ width=35, hight=35, autoscale=true } 
	)
	
	local srf_alertcnt = Field( self, 565, 50, fonts.seg, COL_DIGIT, {
		align = ALIGN_RIGHT,
		bgcolor = COL_TRANSPARENT,
		ownsurface = true,
		transparency = true,
		gradient = GRD_ALERT,
		sample_text = "88"
	})
	MQTTDisplay( 'AlertNbre', MARCEL ..'/AlertsCounter', srf_alertcnt, {
--		debug = 'AlertNbre'
	})

	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

BottomBar = f()

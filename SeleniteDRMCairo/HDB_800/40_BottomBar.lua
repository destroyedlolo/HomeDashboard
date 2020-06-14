local function f()
	local self = Surface( psrf, LBw, psrf:GetHight()-BBh, psrf:GetWidth() - LBw, BBh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()
	local offx=0,offy

	self.setColor( COL_BORDER )
	srf:DrawLine( 0, sh, sw, sh )

	local lvdonotif = ImageFiltreSurface( self, offx, 24, SELENE_SCRIPT_DIR .. "/Images/Mail.png" )
	condition_lvdo = Condition( lvdonotif, 0 )
	local poolnotif = ImageFiltreSurface( self, offx, 0, SELENE_SCRIPT_DIR .. "/Images/Piscine.png" )
	condition_pool = Condition( poolnotif, 0, {
		ok_color = COL_DARKGREEN,
		issue_color = COL_DARKRED
	} )
	offx = offx + 24

	local network = ImageFiltreSurface( self, offx,24, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25, { issue_color=COL_RED } )
	table.insert( additionnalevents, condition_network.getTimer() )

	local freeboxicn = ImageFiltreSurface( self, offx,0, SELENE_SCRIPT_DIR .. "/Images/FreeboxL.png" )
	condition_freebox = Condition(freeboxicn, .5, { autorecover=true, issue_color=COL_RED } )
	table.insert( additionnalevents, condition_freebox.getTimer() )
	offx = offx + 24

	local WiFi = ImageFiltreSurface( self, offx,24, SELENE_SCRIPT_DIR .. "/Images/WiFi.png" )
	condition_WiFi = Condition(WiFi, .5, { autorecover=true, issue_color=COL_RED } )
	table.insert( additionnalevents, condition_WiFi.getTimer() )
	local WiFiNoStations = MQTTinput('WiFiNoStations', 'ESPRouter_Domo/NoStations', nil, { condition=condition_WiFi, watchdog=wdWiFi } )

	local barriere = ImageFiltreSurface( self, offx,0, SELENE_SCRIPT_DIR .. "/Images/BarrierePoule.png" )
	condition_BarrierePoule = Condition( barriere, 0, {issue_color=COL_RED } )
	offx = offx + 24

	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

BottomBar = f()

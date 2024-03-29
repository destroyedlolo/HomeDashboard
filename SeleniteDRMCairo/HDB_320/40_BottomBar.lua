local function f()
	local self = Surface( psrf, LBw, psrf:GetHight()-BBh, psrf:GetWidth() - LBw, BBh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()
	local offx=0,offy

	function self.Clear()
		-- notez-bien : full redrawing is not needed (yet ?) as this
		-- bar is ALWAYS displayed
		self.get():Clear(COL_BLACK.get() )
		self.setColor( COL_BORDER )
		srf:DrawLine( 0,0 , sw,0 )
	end
	self.Clear() -- clean the surface before displaying

	local lvdonotif = ImageFiltreSurface( self, offx, 1, SELENE_SCRIPT_DIR .. "/Images/Mail.png" )
	condition_lvdo = Condition( lvdonotif, 0 )
	offx = offx + 24
	local poolnotif = ImageFiltreSurface( self, offx, 1, SELENE_SCRIPT_DIR .. "/Images/Piscine.png" )
	condition_pool = Condition( poolnotif, 0, {
		ok_color = COL_DARKGREEN,
		issue_color = COL_DARKRED
	} )
	offx = offx + 24

	local network = ImageFiltreSurface( self, offx,1, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25, { issue_color=COL_RED } )
	table.insert( additionnalevents, condition_network.getTimer() )
	offx = offx + 24

	local barriere = ImageFiltreSurface( self, offx,1, SELENE_SCRIPT_DIR .. "/Images/BarrierePoule.png" )
	condition_BarrierePoule = Condition( barriere, 0, {issue_color=COL_RED } )
	offx = offx + 24

	Notification = NotificationArea( self, offx, 1, 125, sh, fonts.xstxt, COL_DARKGREEN, { bgcolor=COL_GFXBG } )
	local log = MQTTLog('messages', 'messages', Notification, { udata=-1 } )
	log.RegisterTopic('messages', 'messages/Erreur', { udata=3 } )
	offx = offx + 125

	Saison( self, 'Saison', MAJORDOME ..'/Saison', offx, 1 )

	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

BottomBar = f()

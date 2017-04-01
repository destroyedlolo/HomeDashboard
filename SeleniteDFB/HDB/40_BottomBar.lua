local function f()
	local sw = psrf:GetWidth() - LBw
	local sh = fstxt:GetHeight() * NotLine

	local self = SubSurface( psrf, LBw, psrf:GetHeight()-sh, sw, sh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	local network = ImageFiltreSurface( srf, 0,24, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25 )
	table.insert( condlisttmr, condition_network.getTimer() )

	Notification = NotificationArea( srf, 24, 0, 200, sh, fstxt, COL_LIGHTGREY, { bgcolor=COL_GFXBG } )

	self.refresh()
	return self
end

BottomBar = f()

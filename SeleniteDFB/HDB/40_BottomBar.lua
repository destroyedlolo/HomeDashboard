local function f()
	local sw = psrf:GetWidth() - LBw
	local sh = fstxt:GetHeight()*4

	local self = SubSurface( psrf, LBw, psrf:GetHeight()-sh, sw, sh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	local network = ImageFiltreSurface( srf, 0,0, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25 )
	table.insert( condlisttmr, condition_network.getTimer() )


local tst = TextArea( srf, 50, 0, 150, sh, fstxt, COL_BLACK, { bgcolor=COL_LIGHTGREY } )
tst.DrawString( 'Log 1' )
tst.CR()
tst.DrawString( 'Log ++++++++++++++++' )
tst.CR()
tst.DrawString( 'Log ++++++++++++++++' )
tst.CR()
tst.DrawString( 'Log ++++++++++++++++' )
print("Taille log", sh)
	self.refresh()
	return self
end

BottomBar = f()

local function f()
	local sw = psrf:GetWidth() - LBw
	local sh = fstxt:GetHeight()*4

	local self = SubSurface( psrf, LBw, psrf:GetHeight()-sh, sw, sh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	local network = ImageFiltreSurface( srf, 0,24, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25 )
	table.insert( condlisttmr, condition_network.getTimer() )


local tst = TextArea( srf, 24, 0, 150, sh, fstxt, COL_WHITE, { bgcolor=COL_GFXBG } )
tst.DrawString( 'Log 1' )
tst.CR()
tst.DrawString( 'Log ++++++++++++++++' )
tst.CR()
tst.DrawString( 'Log ++++++++++++++++' )
tst.CR()
tst.DrawString( '0123456789012345678901234567890123456789' )
print("Taille log", sh)
	self.refresh()
	return self
end

BottomBar = f()

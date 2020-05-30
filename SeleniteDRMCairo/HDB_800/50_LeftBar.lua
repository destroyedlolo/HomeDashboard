local function f()
	self = Surface( psrf, 0,0,LBw, psrf:GetHight() )

	-- build graphics

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHight() )

	local offy = 3 + fonts.title1.size
	self.setColor( COL_TITLE )
	self.setFont( fonts.title1 )
	srf:DrawString("Tension EDF :", 5, offy )

print(srf:Dump("/tmp","tst"))

	return self
end

LeftBar = f()


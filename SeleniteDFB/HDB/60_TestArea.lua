-- Scratch pad to test some function

local function f()
	self = SubSurface( psrf, 
		LeftBar.get():GetWidth(),0,
		psrf:GetWidth() - LeftBar.get():GetWidth(), psrf:GetHeight()
	)
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	local network = FiltreSurface( srf, 0,0, SELENE_SCRIPT_DIR .. "/Images/Network.png" )

	self.refresh()

	return self
end

TestArea = f()


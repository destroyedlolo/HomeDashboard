-- Scratch pad to test some function

local function f()
	self = SubSurface( psrf, 
		LeftBar.get():GetWidth(),0,
		psrf:GetWidth() - LeftBar.get():GetWidth(), psrf:GetHeight()-BottomBar.get():GetHeight()
	)
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	local w0 = Weather3H('Meteo3H', 'Nonglard', 0)

	self.refresh()

	return self
end

TestArea = f()


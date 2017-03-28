local function f()
	local sw = psrf:GetWidth() - LeftBar.get():GetWidth()
	local sh = fsdigit:GetHeight()*6

	self = SubSurface( psrf, LeftBar.get():GetWidth(), psrf:GetHeight()-sh, sw, sh )


	self.refresh()

	return self
end

BottomBar = f()

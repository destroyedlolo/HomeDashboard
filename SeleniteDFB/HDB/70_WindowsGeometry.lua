-- All sub windows geometry

WINx = LeftBar.get():GetWidth() + 1
WINy = 0

WINw = psrf:GetWidth() - WINx
WINh = psrf:GetHeight() --[[ - BottomBar.get():GetWidth() ]]

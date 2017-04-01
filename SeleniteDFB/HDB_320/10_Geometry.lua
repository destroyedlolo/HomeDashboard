LBw = 100 -- Left bar width
HSGRPH = 20	-- Height of small graphs
NotLine = 4	-- Nbre of lines in notification area


-- All sub windows geometry

WINx = LBw + 1
WINy = 0

WINw = psrf:GetWidth() - WINx
WINh = psrf:GetHeight() --[[ - BottomBar.get():GetWidth() ]]

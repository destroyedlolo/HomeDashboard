LBw = 160 -- Left bar width
HSGRPH = 30	-- Height of small graphs
NotLine = 4	-- Nbre of lines in notification area
BBh = fstxt:GetHeight() * NotLine	-- BottomBar's height

-- All sub windows geometry

WINx = LBw + 1
WINy = 0

WINw = psrf:GetWidth() - WINx
WINh = psrf:GetHeight() --[[ - BottomBar.get():GetWidth() ]]

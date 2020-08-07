-- Global geometry of the display

LBw = 100 -- Left bar width
HSGRPH = 20	-- Height of small graphs
NotLine = 4	-- Nbre of lines in notification area
BBh = fonts.xstxt.size * NotLine + 1	-- BottomBar's hight

-- All sub windows geometry

WINTOP = { x = LBw + 1, y = 0 }
WINSIZE = { w = psrf:GetWidth() - WINTOP.x, h = psrf:GetHight() - BBh }


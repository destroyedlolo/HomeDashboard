LBw = 100 -- Left bar width
HSGRPH = 20	-- Hight of small graphs
NotLine = 4	-- Nbre of lines in notification area
BBh = fstxt:GetHeight() * NotLine	-- BottomBar's height


-- All sub windows geometry
WINTOP = { LBw + 1, 0 }
WINSIZE = { psrf:GetWidth() - WINTOP[1], psrf:GetHight() - BBh }


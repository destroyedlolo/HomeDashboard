-- Global geometry of the display

LBw = 160 -- Left bar width
HSGRPH = 30	-- Hight of small graphs
NotLine = 4	-- Nbre of lines in notification area
BBh = FONT["fstxt"].size * NotLine	-- BottomBar's hight

-- All sub windows geometry

WINTOP = { LBw + 1, 0 }
WINSIZE = { psrf:GetWidth() - WINTOP[1], psrf:GetHight() - BBh }


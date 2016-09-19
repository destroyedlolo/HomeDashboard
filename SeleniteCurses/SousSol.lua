-- This file define the window related to the basement "Sous sol"
local x,y

pwnd:print("\nCave: ")
x,y = pwnd:GetXY()
TCave = pwnd:DerWin(x,y,5,1)
TCave:attrset( SelCurses.CharAttrConst("BOLD") )
pwnd:print(" ??.?°C,  Congélateur: ")
x,y = pwnd:GetXY()
TCongelo = pwnd:DerWin(x,y,5,1)
TCongelo:attrset( SelCurses.CharAttrConst("BOLD") )
pwnd:print(" ??.?°C,  Porte: ")
x,y = pwnd:GetXY()
TCaveP = pwnd:DerWin(x,y,5,1)
TCaveP:attrset( SelCurses.CharAttrConst("BOLD") )
pwnd:print(" ??.?°C ")
xSitP, uSitP = pwnd:GetXY()

function updateTCave()
	TCave:clear()
	TCave:print( string.format("%4.1f", SelShared.get('maison/Temperature/Cave')) )
	TCave:refresh()
end

function updateTCaveP()
	TCaveP:clear()
	TCaveP:print( string.format("%4.1f", SelShared.get('maison/Temperature/CaveP')) )
	TCaveP:refresh()
end

function updateTCongelo()
	TCongelo:clear()
	TCongelo:print( string.format("%4.1f", SelShared.get('maison/Temperature/CaveP')) )
	TCongelo:refresh()
end

function updatePorteCave()
	pwnd:Move(xSitP, uSitP)
	pwnd:clrtoeol()
	pwnd:print( SelShared.get('maison/IO/Porte_Cave') )
end

-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Cave", trigger=updateTCave, trigger_once=true },
	{ topic = "maison/Temperature/CaveP", trigger=updateTCaveP, trigger_once=true },
	{ topic = "maison/Temperature/Congelateur", trigger=updateTCongelo, trigger_once=true },
	{ topic = "maison/IO/Porte_Cave", trigger=updatePorteCave, trigger_once=true }
}

TableMerge( Topics, ltopics)


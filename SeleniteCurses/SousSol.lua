-- This file define the window related to the basement "Sous sol"
local x,y

pwnd:print('\nGarage: ')
x,y = pwnd:GetXY()
TGarage = pwnd:DerWin(x,y,5,1)
TGarage:attrset( SelCurses.CharAttrConst('BOLD') )
pwnd:print(' ??.?"C,  Congelateur: ')
x,y = pwnd:GetXY()
TCongelo = pwnd:DerWin(x,y,5,1)
TCongelo:attrset( SelCurses.CharAttrConst('BOLD') )
pwnd:print(' ??.?"C,  Porte: ')
x,y = pwnd:GetXY()
TGarageP = pwnd:DerWin(x,y,5,1)
TGarageP:attrset( SelCurses.CharAttrConst('BOLD') )
pwnd:print(' ??.?"C ')
xSitPG, uSitPG = pwnd:GetXY()

function updateTGarage()
	TGarage:clear()
	TGarage:print( string.format('%4.1f', SelShared.Get('maison/Temperature/Garage')) )
	TGarage:refresh()
end

function updateTGarageP()
	TGarageP:clear()
	TGarageP:print( string.format('%4.1f', SelShared.Get('maison/Temperature/GarageP')) )
	TGarageP:refresh()
end

function updateTCongelo()
	TCongelo:clear()
	TCongelo:print( string.format('%4.1f', SelShared.Get('maison/Temperature/Congelateur')) )
	TCongelo:refresh()
end

function updatePorteGarage()
	pwnd:Move(xSitPG, uSitPG)
	pwnd:clrtoeol()
	pwnd:print( SelShared.Get('maison/IO/Porte_Garage') )
	pwnd:refresh()
end

-- local subscription
local ltopics = {
	{ topic = 'maison/Temperature/Garage', trigger=updateTGarage, trigger_once=true },
	{ topic = 'maison/Temperature/GarageP', trigger=updateTGarageP, trigger_once=true },
	{ topic = 'maison/Temperature/Congelateur', trigger=updateTCongelo, trigger_once=true },
	{ topic = 'maison/IO/Porte_Garage', trigger=updatePorteGarage, trigger_once=true }
}

TableMerge( Topics, ltopics)


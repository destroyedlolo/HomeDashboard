-- This file define the window related to the "1st floor"
local x,y

pwnd:print('\nGr. Sud: ')
x,y = pwnd:GetXY()
TChGS= pwnd:DerWin(x,y,5,1)
TChGS:attrset( SelCurses.CharAttrConst('BOLD') )

pwnd:print(' ??.?"C,  Gr. Nord: ')
x,y = pwnd:GetXY()
TChGN= pwnd:DerWin(x,y,5,1)
TChGN:attrset( SelCurses.CharAttrConst('BOLD') )
pwnd:print(' ??.?"C, Comble: ')
x,y = pwnd:GetXY()
srf_TComble= pwnd:DerWin(x,y,5,1)
srf_TComble:attrset( SelCurses.CharAttrConst('BOLD') )
pwnd:print(' ??.?"C')


pwnd:print('\nOceane: ')
x,y = pwnd:GetXY()
TChOceane = pwnd:DerWin(x,y,5,1)
TChOceane:attrset( SelCurses.CharAttrConst('BOLD') )
pwnd:print(' ??.?"C,  Joris: ')
x,y = pwnd:GetXY()
TChJoris = pwnd:DerWin(x,y,5,1)
TChJoris:attrset( SelCurses.CharAttrConst('BOLD') )
pwnd:print(' ??.?"C,  Parents: ')
x,y = pwnd:GetXY()
TChParents = pwnd:DerWin(x,y,5,1)
TChParents:attrset( SelCurses.CharAttrConst('BOLD') )
pwnd:print(' ??.?"C')

function updateTGrS()
	TChGS:clear()
	TChGS:print( string.format('%4.1f', SelShared.Get('maison/Temperature/Grenier Sud')) )
	TChGS:refresh()
end

function updateTGrN()
	TChGN:clear()
	TChGN:print( string.format('%4.1f', SelShared.Get('maison/Temperature/Grenier Nord')) )
	TChGN:refresh()
end

function updateTChJ()
	TChJoris:clear()
	TChJoris:print( string.format('%4.1f', SelShared.Get('maison/Temperature/Chambre Joris')) )
	TChJoris:refresh()
end

function updateTChO()
	TChOceane:clear()
	TChOceane:print( string.format('%4.1f', SelShared.Get('maison/Temperature/Chambre Oceane')) )
	TChOceane:refresh()
end

function updateTChP()
	TChParents:clear()
	TChParents:print( string.format('%4.1f', SelShared.Get('maison/Temperature/Chambre Parents')) )
	TChParents:refresh()
end

function updateTComble()
	srf_TComble:clear()
	srf_TComble:print( string.format('%4.1f', SelShared.Get('maison/Temperature/Comble')) )
	srf_TComble:refresh()
end

-- local subscription
local ltopics = {
	{ topic = 'maison/Temperature/Grenier Sud', trigger=updateTGrS, trigger_once=true },
	{ topic = 'maison/Temperature/Grenier Nord', trigger=updateTGrN, trigger_once=true },
	{ topic = 'maison/Temperature/Chambre Joris', trigger=updateTChJ, trigger_once=true },
	{ topic = 'maison/Temperature/Chambre Oceane', trigger=updateTChO, trigger_once=true },
	{ topic = 'maison/Temperature/Chambre Parents', trigger=updateTChP, trigger_once=true },
	{ topic = 'maison/Temperature/Comble', trigger=updateTComble, trigger_once=true }
}

TableMerge( Topics, ltopics)



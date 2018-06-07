-- Pool's information

local x,y
pwnd:print('\nPiscine T: ')
x,y = pwnd:GetXY()
TPiscine = pwnd:DerWin(x,y,5,1)
TPiscine:attrset( SelCurses.CharAttrConst('BOLD') )

function updateTPiscine()
	TPiscine:clear()
	TPiscine:print( string.format('%4.1f', SelShared.get('SondePiscine/TempPiscine')) )
	TPiscine:refresh()
end

pwnd:print(' ??.?"C,  S: ')
x,y = pwnd:GetXY()
TSonde = pwnd:DerWin(x,y,5,1)
TSonde:attrset( SelCurses.CharAttrConst('BOLD') )

function updateTSonde()
	TSonde:clear()
	TSonde:print( string.format('%4.1f', SelShared.get('SondePiscine/TempInterne')) )
	TSonde:refresh()
end

pwnd:print(' ??.?"C,  V: ')
x,y = pwnd:GetXY()
VPiscine = pwnd:DerWin(x,y,5,1)
VPiscine:attrset( SelCurses.CharAttrConst('BOLD') )

function updateVPoul()
	VPiscine:clear()
	VPiscine:print( string.format('%2.2f', SelShared.get('SondePiscine/Vcc')/1000) )
	VPiscine:refresh()
end

pwnd:print(' ?.?? V')

local ltopics = {
	{ topic = 'SondePiscine/TempPiscine', trigger=updateTPiscine, trigger_once=true },
	{ topic = 'SondePiscine/TempInterne', trigger=updateTSonde, trigger_once=true },
	{ topic = 'SondePiscine/Vcc', trigger=updateVPoul, trigger_once=true },
}

TableMerge( Topics, ltopics)

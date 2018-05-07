-- This file displays outdoor information

local x,y
pwnd:print('\nPoulailler T: ')
x,y = pwnd:GetXY()
TPoul = pwnd:DerWin(x,y,5,1)
TPoul:attrset( SelCurses.CharAttrConst('BOLD') )

function updateTPoul()
	TPoul:clear()
	TPoul:print( string.format('%4.1f', SelShared.get('Poulailler/Perchoir/Temperature')) )
	TPoul:refresh()
end

pwnd:print(' ??.?"C,  H: ')
x,y = pwnd:GetXY()
HPoul = pwnd:DerWin(x,y,5,1)
HPoul:attrset( SelCurses.CharAttrConst('BOLD') )

function updateHPoul()
	HPoul:clear()
	HPoul:print( string.format('%3.1f', SelShared.get('Poulailler/Perchoir/Humidite')) )
	HPoul:refresh()
end

pwnd:print(' ??.? %, V: ')
x,y = pwnd:GetXY()
VPoul = pwnd:DerWin(x,y,5,1)
VPoul:attrset( SelCurses.CharAttrConst('BOLD') )

function updateVPoul()
	VPoul:clear()
	VPoul:print( string.format('%2.2f', SelShared.get('Poulailler/Alim')/1000) )
	VPoul:refresh()
end

pwnd:print(' ?.?? V')



-- local subscription
local ltopics = {
	{ topic = 'Poulailler/Perchoir/Temperature', trigger=updateTPoul, trigger_once=true },
	{ topic = 'Poulailler/Perchoir/Humidite', trigger=updateHPoul, trigger_once=true },
	{ topic = 'Poulailler/Alim', trigger=updateVPoul, trigger_once=true },
}

TableMerge( Topics, ltopics)

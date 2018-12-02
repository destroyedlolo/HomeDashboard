function FermeAuto()
	wmdSub:clear()
	wmdSub:refresh()

	Mode=''
	genMenu()

	actWnd = nil
end


function initAuto()
	local x,y
	Mode='A'

	wmdSub:clear()
	wmdSub:border()

	wmdSub:Move(2,1)
	genTitre(wmdSub, '&Saison : ')
	x,y = wmdSub:GetXY()
	Saison = wmdSub:DerWin(x,y,14,1)
	Saison:attrset( SelCurses.CharAttrConst('BOLD') )
	updateSaison()
	wmdSub:Move(x + 17,1)
	wmdSub:print('(');
	SaisonH = wmdSub:DerWin(x+19,y,14,1)
	SaisonH:attrset( SelCurses.CharAttrConst('BOLD') )
	wmdSub:Move(x + 34,1)
	wmdSub:print(')');

	wmdSub:Move(2,2)
	wmdSub:print('Mode reel : ')
	x,y = wmdSub:GetXY()
	ModeR = wmdSub:DerWin(x,y,14,1)
	ModeR:attrset( SelCurses.CharAttrConst('BOLD') )
	updateModeR()

	wmdSub:refresh()
	genMenu()
end

function keyAuto(Brk, c,cn)
end

swinLst['M'] = { titre="&Majordome", func=initAuto, key=keyAuto, close=FermeAuto }

-- Topics

function updateSaison()
	if Mode == 'A' then
		Saison:clear()
		Saison:print(SelShared.Get('Majordome/Saison'))
		Saison:refresh()
	end
end

function updateSaisonH()
	if Mode == 'A' then
		SaisonH:clear()
		SaisonH:print(SelShared.Get('Majordome/Saison/Hier'))
		SaisonH:refresh()
	end
end

function updateModeR()
	if Mode == 'A' then
		ModeR:clear()
		ModeR:print(SelShared.Get('Majordome/Mode'))
		ModeR:refresh()
	end
end

local ltopics = {
	{ topic = 'Majordome/Saison', trigger=updateSaison, trigger_once=true },
	{ topic = 'Majordome/Saison/Hier', trigger=updateSaisonH, trigger_once=true },
	{ topic = 'Majordome/Mode', trigger=updateModeR, trigger_once=true },
}
TableMerge( Topics, ltopics)

-- Valeurs par défauts (pour éviter un crash si elle ne sont pas définies)

SelShared.Set('Majordome/Saison', '?')
SelShared.Set('Majordome/Saison/Hier', '?')
SelShared.Set('Majordome/Mode', '?')


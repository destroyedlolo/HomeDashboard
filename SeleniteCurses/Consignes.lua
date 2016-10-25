-- Gestion des consignes

function updateMForce()
	if Mode == 'C' then
		MForce:clear()
		MForce:print( SelShared.get('Majordome/Mode/Force') )
		MForce:refresh()
	end
end

function updateMForceEnfants()
	if Mode == 'C' then
		MForceE:clear()
		MForceE:print( SelShared.get('Majordome/Mode/Enfants') )
		MForceE:refresh()
	end
end

function initConsignes()
	local x,y
	Mode='C'
	
	wmdSub:clear()
	wmdSub:border()

	wmdSub:attrset( SelCurses.CharAttrConst("UNDERLINE") )
	wmdSub:PrintAt(12,1, 'Modes')
	wmdSub:attrset( SelCurses.CharAttrConst("NORMAL") )

	wmdSub:Move(2,2)
	genTitre(wmdSub, 'F&orce : ')
	x,y = wmdSub:GetXY()
	if not MForce then
		MForce = wmdSub:DerWin(x,y,8,1)
		MForce:attrset( SelCurses.CharAttrConst('BOLD') )
	end
	updateMForce()

	wmdSub:Move(2,3)
	genTitre(wmdSub, 'Force &enfants : ')
	x,y = wmdSub:GetXY()
	MForceE = wmdSub:DerWin(x,y,8,1)
	MForceE:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEnfants()

	wmdSub:refresh()
	genMenu()
end

function FermeConsignes()
	wmdSub:clear()
	wmdSub:refresh()

	Mode=''
	genMenu()

	actWnd = nil
end

swinLst['C'] = { titre="&Consignes", func=initConsignes, key=keyVolets, close=FermeConsignes }

-- Topics

local ltopics = {
	{ topic = 'Majordome/Mode/Force', trigger=updateMForce, trigger_once=true },
	{ topic = 'Majordome/Mode/Enfants', trigger=updateMForceEnfants, trigger_once=true },
}

TableMerge( Topics, ltopics)


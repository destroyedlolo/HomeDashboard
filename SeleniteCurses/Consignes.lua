-- Gestion des consignes

function updateMForce()
	if Mode == 'C' then
		MForce:clear()
		MForce:print( SelShared.Get('Majordome/Mode/Force') )
		MForce:refresh()
	end
end

function updateMForceEnfants()
	if Mode == 'C' then
		MForceE:clear()
		MForceE:print( SelShared.Get('Majordome/Mode/Force/Enfants') )
		MForceE:refresh()
	end
end

function updateMForceEOceane()
SelLog.log(">>> FEO")
	if Mode == 'C' then
SelLog.log(">>> FEO 1")
		MForceEO:clear()
SelLog.log(">>> FEO 2")
		MForceEO:print( SelShared.get('Majordome/Mode/Force/Enfants/Oceane') )
SelLog.log(">>> FEO 3")
		MForceEO:refresh()
SelLog.log(">>> FEO f")
	end
end

function updateMForceEJoris()
	if Mode == 'C' then
		MForceEJ:clear()
		MForceEJ:print( SelShared.get('Majordome/Mode/Force/Enfants/Joris') )
		MForceEJ:refresh()
	end
end

function updateMForceParents()
	if Mode == 'C' then
		MForceP:clear()
		MForceP:print( SelShared.get('Majordome/Mode/Force/Parents') )
		MForceP:refresh()
	end
end

function updateMPiscine()
	if Mode == 'C' then
		MPiscine:clear()
		local v = SelShared.get('Majordome/Mode/Piscine')
		if v == 'Forcé' then
			MPiscine:print('Force')
		else
		MPiscine:print(v)
		end
		MPiscine:refresh()
	end
end

function popupConsMode( Brk, topic )
	local w,h = wmdSub:GetSize()

	local popup = wmdSub:DerWin((w-15)/2,2, 15,7)

	genTitre(popup, "\n  &Auto\n")
	genTitre(popup, "  &Manuel\n")
	genTitre(popup, "  &Travail\n")
	genTitre(popup, "  &Vacances\n")
	genTitre(popup, "  A&bsent\n")

	popup:border()
	popup:refresh()

	local c = string.upper(string.char(popup:getch()))

	if c == 'A' then
		Brk:Publish( topic, "Auto", true)
	elseif c == 'M' then
		Brk:Publish( topic, "Manuel", true)
	elseif c == 'T' then
		Brk:Publish( topic, "Travail", true)
	elseif c == 'V' then
		Brk:Publish( topic, "Vacances", true)
	elseif c == 'B' then
		Brk:Publish( topic, "Absent", true)
	end

	popup:delwin()
end

function popupConsPiscine( Brk, topic )
	local w,h = wmdSub:GetSize()

	local popup = wmdSub:DerWin((w-15)/2,2, 18,5)

	genTitre(popup, "\n  &Heures Creuses\n")
	genTitre(popup, "  &Arret\n")
	genTitre(popup, "  &Force\n")

	popup:border()
	popup:refresh()

	local c = string.upper(string.char(popup:getch()))

	if c == 'H' then
		Brk:Publish( topic, "Heures Creuses", true)
	elseif c == 'A' then
		Brk:Publish( topic, "Arret", true)
	elseif c == 'F' then
		Brk:Publish( topic, "Forcé", true)
	end

	popup:delwin()
end

function keyConsignes(Brk, c,cn)
	if c == 'r' then
		popupConsMode( Brk, 'Majordome/Mode/Force' )
	elseif c == 'e' then
		popupConsMode( Brk, 'Majordome/Mode/Force/Enfants' )
	elseif c == 'c' then
		popupConsMode( Brk, 'Majordome/Mode/Force/Enfants/Oceane' )
	elseif c == 'o' then
		popupConsMode( Brk, 'Majordome/Mode/Force/Enfants/Joris' )
	elseif c == 'p' then
		popupConsMode( Brk, 'Majordome/Mode/Force/Parents' )
	elseif c == 'i' then
		popupConsPiscine( Brk, 'Majordome/Mode/Piscine' )
	end

	initConsignes()
end

function initConsignes()
	local x,y
	Mode='C'

SelLog.log("*** i0 ***")
	wmdSub:clear()
	wmdSub:border()
SelLog.log("*** i1 ***")

	wmdSub:attrset( SelCurses.CharAttrConst("UNDERLINE") )
	wmdSub:PrintAt(12,1, 'Modes')
	wmdSub:attrset( SelCurses.CharAttrConst("NORMAL") )
SelLog.log("*** i2 ***")

	wmdSub:Move(2,2)
	genTitre(wmdSub, 'Fo&rce : ')
	x,y = wmdSub:GetXY()
	if not MForce then
		MForce = wmdSub:DerWin(x,y,8,1)
		MForce:attrset( SelCurses.CharAttrConst('BOLD') )
	end
	updateMForce()
SelLog.log("*** i3 ***")

	wmdSub:Move(2,3)
	genTitre(wmdSub, 'Force &enfants : ')
	x,y = wmdSub:GetXY()
	MForceE = wmdSub:DerWin(x,y,8,1)
	MForceE:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEnfants()
SelLog.log("*** i4 ***")

	wmdSub:Move(5,4)
SelLog.log("*** i41 ***")
	genTitre(wmdSub, 'O&ceane : ')
SelLog.log("*** i42 ***")
	x,y = wmdSub:GetXY()
SelLog.log("*** i43 ***")
	MForceEO = wmdSub:DerWin(x,y,8,1)
SelLog.log("*** i44 ***")
	MForceEO:attrset( SelCurses.CharAttrConst('BOLD') )
SelLog.log("*** i45 ***")
	updateMForceEOceane()
SelLog.log("*** i5 ***")

	wmdSub:Move(6,5)
	genTitre(wmdSub, 'J&oris : ')
	x,y = wmdSub:GetXY()
	MForceEJ = wmdSub:DerWin(x,y,8,1)
	MForceEJ:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEJoris()

	wmdSub:Move(2,6)
	genTitre(wmdSub, 'Force &parents: ')
	x,y = wmdSub:GetXY()
	MForceP = wmdSub:DerWin(x,y,8,1)
	MForceP:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceParents()

	wmdSub:Move(2,8)
	genTitre(wmdSub, 'P&iscine : ')
	x,y = wmdSub:GetXY()
	MPiscine = wmdSub:DerWin(x,y,14,1)
	MPiscine:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMPiscine()
SelLog.log("*** if ***")

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

swinLst['C'] = { titre="&Consignes", func=initConsignes, key=keyConsignes, close=FermeConsignes }

-- Topics

local ltopics = {
	{ topic = 'Majordome/Mode/Force', trigger=updateMForce, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/Enfants', trigger=updateMForceEnfants, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/Enfants/Oceane', trigger=updateMForceEOceane, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/Enfants/Joris', trigger=updateMForceEJoris, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/Parents', trigger=updateMForceParents, trigger_once=true },
	{ topic = 'Majordome/Mode/Piscine', trigger=updateMPiscine, trigger_once=true },
}

TableMerge( Topics, ltopics)

-- Valeurs par défauts (pour éviter un crash si elle ne sont pas définies)

SelShared.Set('Majordome/Mode/Force', '?')
SelShared.Set('Majordome/Mode/Force/Enfants', '?')
SelShared.Set('Majordome/Mode/Force/Enfants/Oceane', '?')
SelShared.Set('Majordome/Mode/Force/Enfants/Joris', '?')
SelShared.Set('Majordome/Mode/Force/Parents', '?')
SelShared.Set('Majordome/Mode/Piscine', 'Heures Creuses')

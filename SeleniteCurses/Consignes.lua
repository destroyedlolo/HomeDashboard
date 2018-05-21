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
		MForceE:print( SelShared.get('Majordome/Mode/Force/Enfants') )
		MForceE:refresh()
	end
end

function updateMForceEOceane()
	if Mode == 'C' then
		MForceEO:clear()
		MForceEO:print( SelShared.get('Majordome/Mode/Force/Enfants/Oceane') )
		MForceEO:refresh()
	end
end

function updateMForceEJoris()
	if Mode == 'C' then
		MForceEJ:clear()
		MForceEJ:print( SelShared.get('Majordome/Mode/Force/Enfants/Joris') )
		MForceEJ:refresh()
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

function keyConsignes(Brk, c,cn)
	if c == 'r' then
		popupConsMode( Brk, 'Majordome/Mode/Force' )
	elseif c == 'e' then
		popupConsMode( Brk, 'Majordome/Mode/Force/Enfants' )
	elseif c == 'c' then
		popupConsMode( Brk, 'Majordome/Mode/Force/Enfants/Oceane' )
	elseif c == 'o' then
		popupConsMode( Brk, 'Majordome/Mode/Force/Enfants/Joris' )
	end

	initConsignes()
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
	genTitre(wmdSub, 'Fo&rce : ')
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

	wmdSub:Move(5,4)
	genTitre(wmdSub, 'O&ceane : ')
	x,y = wmdSub:GetXY()
	MForceEO = wmdSub:DerWin(x,y,8,1)
	MForceEO:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEOceane()

	wmdSub:Move(6,5)
	genTitre(wmdSub, 'J&oris : ')
	x,y = wmdSub:GetXY()
	MForceEJ = wmdSub:DerWin(x,y,8,1)
	MForceEJ:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEJoris()

--[[
	wmdSub:Move(2,4)
	genTitre(wmdSub, 'Force &parents: ')
	x,y = wmdSub:GetXY()
--]]

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
}

TableMerge( Topics, ltopics)

-- Valeurs par défauts (pour éviter un crash si elle ne sont pas définies)

SelShared.set('Majordome/Mode/Force', '?')
SelShared.set('Majordome/Mode/Force/Enfants', '?')
SelShared.set('Majordome/Mode/Force/Enfants/Oceane', '?')
SelShared.set('Majordome/Mode/Force/Enfants/Joris', '?')
SelShared.set('Majordome/Mode/Force/Parents', '?')

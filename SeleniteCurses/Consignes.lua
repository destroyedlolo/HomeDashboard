-- Gestion des consignes

function updateMForce()
	if Mode == 'C' then
		MForce:clear()
		MForce:print( SelShared.Get('Majordome/Mode/Force') )
		MForce:refresh()
	end
end

function updateMActif()
	if Mode == 'C' then
		MActif:clear()
		MActif:print( SelShared.Get('Majordome/Mode') )
		MActif:refresh()
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
	if Mode == 'C' then
		MForceEO:clear()
		MForceEO:print( SelShared.Get('Majordome/Mode/Force/Enfants/Oceane') )
		MForceEO:refresh()
	end
end

function updateMForceEJoris()
	if Mode == 'C' then
		MForceEJ:clear()
		MForceEJ:print( SelShared.Get('Majordome/Mode/Force/Enfants/Joris') )
		MForceEJ:refresh()
	end
end

function updateMForceParents()
	if Mode == 'C' then
		MForceP:clear()
		MForceP:print( SelShared.Get('Majordome/Mode/Force/Parents') )
		MForceP:refresh()
	end
end

function updateMForceChAmis()
	if Mode == 'C' then
		MForceA:clear()
		MForceA:print( SelShared.Get('Majordome/Mode/Force/ChAmis') )
		MForceA:refresh()
	end
end

function updateMChAmis()
	if Mode == 'C' then
		MForceAr:clear()
		MForceAr:print( SelShared.Get('Majordome/Mode/ChAmis') )
		MForceAr:refresh()
	end
end

function updateMPiscine()
	if Mode == 'C' then
		MPiscine:clear()
		local v = SelShared.Get('Majordome/Mode/Piscine')
		if v == 'Forcé' then
			MPiscine:print('Force')
		else
		MPiscine:print(v)
		end
		MPiscine:refresh()
	end
end

function updateCCoucher()
	if Mode == 'C' then
		CCoucher:clear()
		CCoucher:print( SelShared.Get('Majordome/HCoucher') )
		CCoucher:refresh()
	end
end

function updateCLvO()
	if Mode == 'C' then
		CLvO:clear()
		CLvO:print( SelShared.Get('Majordome/HLever/Oceane') )
		CLvO:refresh()
	end
end

function updateCLvJ()
	if Mode == 'C' then
		CLvJ:clear()
		CLvJ:print( SelShared.Get('Majordome/HLever/Joris') )
		CLvJ:refresh()
	end
end

function updateCLvP()
	if Mode == 'C' then
		CLvP:clear()
		CLvP:print( SelShared.Get('Majordome/HLever') )
		CLvP:refresh()
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
	elseif c == 'm' then
		popupConsMode( Brk, 'Majordome/Mode/Force/ChAmis' )
	elseif c == 'i' then
		popupConsPiscine( Brk, 'Majordome/Mode/Piscine' )
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
	wmdSub:Move(x+10,y)
	wmdSub:print('(')
	x,y = wmdSub:GetXY()
	MActif = wmdSub:DerWin(x,y,8,1)
	MActif:attrset( SelCurses.CharAttrConst('BOLD') )
	wmdSub:Move(x+10,y)
	wmdSub:print(')')
	updateMActif()

	wmdSub:Move(2,3)
	genTitre(wmdSub, 'Force &enfants : ')
	x,y = wmdSub:GetXY()
	MForceE = wmdSub:DerWin(x,y,8,1)
	MForceE:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEnfants()
	wmdSub:Move(x+10,y)
	genTitre(wmdSub, 'Couc&her : ')
	x,y = wmdSub:GetXY()
	CCoucher = wmdSub:DerWin(x,y,5,1)
	CCoucher:attrset( SelCurses.CharAttrConst('BOLD') )
	updateCCoucher()

	wmdSub:Move(5,4)
	genTitre(wmdSub, 'O&ceane : ')
	x,y = wmdSub:GetXY()
	MForceEO = wmdSub:DerWin(x,y,8,1)
	MForceEO:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEOceane()
	wmdSub:Move(x+10,y)
	genTitre(wmdSub, 'Lever : ')
	x,y = wmdSub:GetXY()
	CLvO = wmdSub:DerWin(x,y,5,1)
	CLvO:attrset( SelCurses.CharAttrConst('BOLD') )
	updateCLvO()

	wmdSub:Move(6,5)
	genTitre(wmdSub, 'J&oris : ')
	x,y = wmdSub:GetXY()
	MForceEJ = wmdSub:DerWin(x,y,8,1)
	MForceEJ:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEJoris()
	wmdSub:Move(x+10,y)
	genTitre(wmdSub, 'Lever : ')
	x,y = wmdSub:GetXY()
	CLvJ = wmdSub:DerWin(x,y,5,1)
	CLvJ:attrset( SelCurses.CharAttrConst('BOLD') )
	updateCLvJ()

	wmdSub:Move(2,6)
	genTitre(wmdSub, 'Force &parents: ')
	x,y = wmdSub:GetXY()
	MForceP = wmdSub:DerWin(x,y,8,1)
	MForceP:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceParents()
	wmdSub:Move(x+10,y)
	genTitre(wmdSub, 'Lever : ')
	x,y = wmdSub:GetXY()
	CLvP = wmdSub:DerWin(x,y,5,1)
	CLvP:attrset( SelCurses.CharAttrConst('BOLD') )
	updateCLvP()

	wmdSub:Move(2,7)
	genTitre(wmdSub, 'Force A&mis: ')
	x,y = wmdSub:GetXY()
	MForceA = wmdSub:DerWin(x,y,8,1)
	MForceA:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceChAmis()
	wmdSub:Move(x+10,y)
	wmdSub:print('(')
	x,y = wmdSub:GetXY()
	MForceAr = wmdSub:DerWin(x,y,8,1)
	MForceAr:attrset( SelCurses.CharAttrConst('BOLD') )
	wmdSub:Move(x+10,y)
	wmdSub:print(')')
	updateMChAmis()

	wmdSub:Move(2,8)
	genTitre(wmdSub, 'P&iscine : ')
	x,y = wmdSub:GetXY()
	MPiscine = wmdSub:DerWin(x,y,14,1)
	MPiscine:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMPiscine()

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
	{ topic = 'Majordome/Mode', trigger=updateMActif, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/Enfants', trigger=updateMForceEnfants, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/Enfants/Oceane', trigger=updateMForceEOceane, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/Enfants/Joris', trigger=updateMForceEJoris, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/Parents', trigger=updateMForceParents, trigger_once=true },
	{ topic = 'Majordome/Mode/Force/ChAmis', trigger=updateMForceChAmis, trigger_once=true },
	{ topic = 'Majordome/Mode/ChAmis', trigger=updateMChAmis, trigger_once=true },
	{ topic = 'Majordome/Mode/Piscine', trigger=updateMPiscine, trigger_once=true },
	{ topic = 'Majordome/HCoucher', trigger=updateCCoucher, trigger_once=true },
	{ topic = 'Majordome/HLever/Oceane', trigger=updateCLvO, trigger_once=true },
	{ topic = 'Majordome/HLever/Joris', trigger=updateCLvJ, trigger_once=true },
	{ topic = 'Majordome/HLever', trigger=updateCLvP, trigger_once=true },
}

TableMerge( Topics, ltopics)

-- Valeurs par défauts (pour éviter un crash si elle ne sont pas définies)

SelShared.Set('Majordome/Mode/Force', '?')
SelShared.Set('Majordome/Mode/Force/Enfants', '?')
SelShared.Set('Majordome/Mode/Force/Enfants/Oceane', '?')
SelShared.Set('Majordome/Mode/Force/Enfants/Joris', '?')
SelShared.Set('Majordome/Mode/Force/Parents', '?')
SelShared.Set('Majordome/Mode/Force/ChAmis', '?')
SelShared.Set('Majordome/Mode/ChAmis', '?')
SelShared.Set('Majordome/Mode/Piscine', 'Heures Creuses')
SelShared.Set('Majordome/HCoucher', '??.??')
SelShared.Set('Majordome/HLever/Oceane', '??.??')
SelShared.Set('Majordome/HLever/Joris', '??.??')
SelShared.Set('Majordome/HLever', '??.??')

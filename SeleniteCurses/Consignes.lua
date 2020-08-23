-- Gestion des consignes

function updateMForce()
	if Mode == 'C' then
		MForce:clear()
		MForce:print( SelShared.Get(MAJORDOME..'/Mode/Force') )
		MForce:refresh()
	end
end

function updateMActif()
	if Mode == 'C' then
		MActif:clear()
		MActif:print( SelShared.Get(MAJORDOME..'/Mode') )
		MActif:refresh()
	end
end

function updateMForceEnfants()
	if Mode == 'C' then
		MForceE:clear()
		MForceE:print( SelShared.Get(MAJORDOME..'/Mode/Force/Enfants') )
		MForceE:refresh()
	end
end

function updateMForceEOceane()
	if Mode == 'C' then
		MForceEO:clear()
		MForceEO:print( SelShared.Get(MAJORDOME..'/Mode/Force/Enfants/Oceane') )
		MForceEO:refresh()
	end
end

function updateMForceEJoris()
	if Mode == 'C' then
		MForceEJ:clear()
		MForceEJ:print( SelShared.Get(MAJORDOME..'/Mode/Force/Enfants/Joris') )
		MForceEJ:refresh()
	end
end

function updateMForceParents()
	if Mode == 'C' then
		MForceP:clear()
		MForceP:print( SelShared.Get(MAJORDOME..'/Mode/Force/Parents') )
		MForceP:refresh()
	end
end

function updateMForceChAmis()
	if Mode == 'C' then
		MForceA:clear()
		MForceA:print( SelShared.Get(MAJORDOME..'/Mode/Force/ChAmis') )
		MForceA:refresh()
	end
end

function updateMChAmis()
	if Mode == 'C' then
		MForceAr:clear()
		MForceAr:print( SelShared.Get(MAJORDOME..'/Mode/ChAmis') )
		MForceAr:refresh()
	end
end

function updateMPiscine()
	if Mode == 'C' then
		MPiscine:clear()
		local v = SelShared.Get(MAJORDOME..'/Mode/Piscine')
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
		CCoucher:print( SelShared.Get(MAJORDOME..'/HCoucher') )
		CCoucher:refresh()
	end
end

function updateCLvO()
	if Mode == 'C' then
		CLvO:clear()
		CLvO:print( SelShared.Get(MAJORDOME..'/HLever/Oceane') )
		CLvO:refresh()
	end
end

function updateCLvJ()
	if Mode == 'C' then
		CLvJ:clear()
		CLvJ:print( SelShared.Get(MAJORDOME..'/HLever/Joris') )
		CLvJ:refresh()
	end
end

function updateCLvP()
	if Mode == 'C' then
		CLvP:clear()
		CLvP:print( SelShared.Get(MAJORDOME..'/HLever') )
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

function popupConsignH( Brk, topic, titre )
	local w,h = wmdSub:GetSize()
	local popup = wmdSub:DerWin((w-20)/2,2, 22,4)
	local res = ""
	
	popup:clear()
	popup:border()
	popup:PrintAt(1,1, titre)

	while(1) do
		popup:refresh()

		local c = popup:getch()
		local len = res:len()

-- popup:PrintAt(1,2, tonumber(c) .. ' ' .. len)

		if c == 27 or c == 113 then	-- Escape or 'q'
			break
		elseif c == 10 and len == 5 then
			Brk:Publish( topic, res, true )
			break
		elseif c == 127 then -- backspace
			if len == 3 then
				res = res:sub(1,1)
			elseif len > 0 then
				res = res:sub(1, len-1 )
			end
		elseif c >= 0x30 and c <= 0x39 and len < 5 then -- number
			c = string.char(c)
			if len == 0 then	-- dizaine
				if c >= '0' and c <= '2' then
					res = res .. c
				end
			elseif len == 1 then -- heure
				if tonumber(res) == 2 then
					if c <= '3' then
						res = res .. c .. '.'
					end
				else
					res = res .. c .. '.'
				end
			elseif len == 3 then	-- dizaine de minutes
				if c <= '5' then
					res = res .. c
				end
			else -- minutes
				res = res .. c
			end
		end

		popup:clear()
		popup:border()
		popup:PrintAt(1,1, titre)
	
		popup:attrset( SelCurses.CharAttrConst("BOLD") )
		popup:PrintAt(4,2, res)
		popup:attrset( SelCurses.CharAttrConst("NORMAL") )
	end

	popup:delwin()
end

function keyConsignes(Brk, c,cn)
	if c == 'o' then
		popupConsMode( Brk, MAJORDOME..'/Mode/Force' )
	elseif c == 'n' then
		popupConsMode( Brk, MAJORDOME..'/Mode/Force/Enfants' )
	elseif c == 'c' then
		popupConsMode( Brk, MAJORDOME..'/Mode/Force/Enfants/Oceane' )
	elseif c == 's' then
		popupConsMode( Brk, MAJORDOME..'/Mode/Force/Enfants/Joris' )
	elseif c == 'p' then
		popupConsMode( Brk, MAJORDOME..'/Mode/Force/Parents' )
	elseif c == 'm' then
		popupConsMode( Brk, MAJORDOME..'/Mode/Force/ChAmis' )
	elseif c == 'i' then
		popupConsPiscine( Brk, MAJORDOME..'/Mode/Piscine' )
	elseif c == 'h' then
		popupConsignH( Brk, MAJORDOME..'/HCoucher', 'Heure coucher' )
	elseif c == 'v' then
		popupConsignH( Brk, MAJORDOME..'/HLever/Oceane', 'Heure lever Oceane' )
	elseif c == 'r' then
		popupConsignH( Brk, MAJORDOME..'/HLever/Joris', 'Heure lever Joris' )
	elseif c == 'e' then
		popupConsignH( Brk, MAJORDOME..'/HLever', 'Heure lever Parents' )
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
	genTitre(wmdSub, 'F&orce : ')
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
	genTitre(wmdSub, 'Force e&nfants : ')
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
	genTitre(wmdSub, 'Le&ver : ')
	x,y = wmdSub:GetXY()
	CLvO = wmdSub:DerWin(x,y,5,1)
	CLvO:attrset( SelCurses.CharAttrConst('BOLD') )
	updateCLvO()

	wmdSub:Move(6,5)
	genTitre(wmdSub, 'Jori&s : ')
	x,y = wmdSub:GetXY()
	MForceEJ = wmdSub:DerWin(x,y,8,1)
	MForceEJ:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceEJoris()
	wmdSub:Move(x+10,y)
	genTitre(wmdSub, 'Leve&r : ')
	x,y = wmdSub:GetXY()
	CLvJ = wmdSub:DerWin(x,y,5,1)
	CLvJ:attrset( SelCurses.CharAttrConst('BOLD') )
	updateCLvJ()

	wmdSub:Move(2,6)
	genTitre(wmdSub, 'Force &parents : ')
	x,y = wmdSub:GetXY()
	MForceP = wmdSub:DerWin(x,y,8,1)
	MForceP:attrset( SelCurses.CharAttrConst('BOLD') )
	updateMForceParents()
	wmdSub:Move(x+10,y)
	genTitre(wmdSub, 'L&ever : ')
	x,y = wmdSub:GetXY()
	CLvP = wmdSub:DerWin(x,y,5,1)
	CLvP:attrset( SelCurses.CharAttrConst('BOLD') )
	updateCLvP()

	wmdSub:Move(2,7)
	genTitre(wmdSub, 'Force A&mis : ')
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
	{ topic = MAJORDOME..'/Mode/Force', trigger=updateMForce, trigger_once=true },
	{ topic = MAJORDOME..'/Mode', trigger=updateMActif, trigger_once=true },
	{ topic = MAJORDOME..'/Mode/Force/Enfants', trigger=updateMForceEnfants, trigger_once=true },
	{ topic = MAJORDOME..'/Mode/Force/Enfants/Oceane', trigger=updateMForceEOceane, trigger_once=true },
	{ topic = MAJORDOME..'/Mode/Force/Enfants/Joris', trigger=updateMForceEJoris, trigger_once=true },
	{ topic = MAJORDOME..'/Mode/Force/Parents', trigger=updateMForceParents, trigger_once=true },
	{ topic = MAJORDOME..'/Mode/Force/ChAmis', trigger=updateMForceChAmis, trigger_once=true },
	{ topic = MAJORDOME..'/Mode/ChAmis', trigger=updateMChAmis, trigger_once=true },
	{ topic = MAJORDOME..'/Mode/Piscine', trigger=updateMPiscine, trigger_once=true },
	{ topic = MAJORDOME..'/HCoucher', trigger=updateCCoucher, trigger_once=true },
	{ topic = MAJORDOME..'/HLever/Oceane', trigger=updateCLvO, trigger_once=true },
	{ topic = MAJORDOME..'/HLever/Joris', trigger=updateCLvJ, trigger_once=true },
	{ topic = MAJORDOME..'/HLever', trigger=updateCLvP, trigger_once=true },
}

TableMerge( Topics, ltopics)

-- Valeurs par défauts (pour éviter un crash si elle ne sont pas définies)

SelShared.Set(MAJORDOME..'/Mode/Force', '?')
SelShared.Set(MAJORDOME..'/Mode/Force/Enfants', '?')
SelShared.Set(MAJORDOME..'/Mode/Force/Enfants/Oceane', '?')
SelShared.Set(MAJORDOME..'/Mode/Force/Enfants/Joris', '?')
SelShared.Set(MAJORDOME..'/Mode/Force/Parents', '?')
SelShared.Set(MAJORDOME..'/Mode/Force/ChAmis', '?')
SelShared.Set(MAJORDOME..'/Mode/ChAmis', '?')
SelShared.Set(MAJORDOME..'/Mode/Piscine', 'Heures Creuses')
SelShared.Set(MAJORDOME..'/HCoucher', '??.??')
SelShared.Set(MAJORDOME..'/HLever/Oceane', '??.??')
SelShared.Set(MAJORDOME..'/HLever/Joris', '??.??')
SelShared.Set(MAJORDOME..'/HLever', '??.??')

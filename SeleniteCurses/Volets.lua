-- Actions manuelles sur les volets

local defVolets = {
	{ lbl="Oceane", grp=1, topic='maison/Volet/chOceane' },
	{ lbl="Joris", grp=1, topic='maison/Volet/chJoris' },
	{ lbl="Parents", grp=1, topic='maison/Volet/chParents' },
	{ lbl="Cheminee", grp=2, topic='maison/Volet/Salon/Cheminee' },
	{ lbl="Salon", grp=2, topic='maison/Volet/Salon/Fenetre' },
	{ lbl="Balcon", grp=2, topic='maison/Volet/Salon/Balcon' },
	{ lbl="Bureau", grp=3, topic='maison/Volet/Buro' },
	{ lbl="Ch Amis", grp=3, topic='maison/Volet/chAmis' },
	{ lbl="Cuisine", grp=3, topic='maison/Volet/Cuisine/Fenetre' },
	{ lbl="Chat", grp=3, topic='maison/Volet/Cuisine/Chat' },
}

function keyVolets(Brk, c,cn)
	if cn == SelCurses.Key("DOWN") then
		if defVolets[selV] ~= nil then
			Brk:Publish(defVolets[selV].topic, 'Down')
		end
	elseif cn == SelCurses.Key("UP") then
		if defVolets[selV] ~= nil then
			Brk:Publish(defVolets[selV].topic, 'Up')
		end
	elseif c == " " then
		if defVolets[selV] ~= nil then
			Brk:Publish(defVolets[selV].topic, 'My')
		end
	elseif c then
		selV = tonumber(c, 16)
		AffVolets()
	end
end

function AffVolets()
	local pg = 0
	local y = 2

	for i,v in ipairs(defVolets)
	do
		if v['grp'] ~= pg then
			pg = v['grp']
			y = y + 1
			wmdSub:Move(3,y)
		else
			wmdSub:print('\t')
		end

		if i == selV then
			wmdSub:attrset( SelCurses.CharAttrConst("REVERSE") )
		end
		wmdSub:print( string.format("%x",i) .. ": " .. v['lbl'] )
		if i == selV then
			wmdSub:attrset( SelCurses.CharAttrConst("NORMAL") )
		end
	end

	wmdSub:refresh()
end

function initVolets()
	local s = " FHaut: Monte, Fbas: Descent, Espace: My ou stop "
	wmdSub:clear()
	wmdSub:border()
	wmdSub:PrintAt((w-s:len())/2,0, s)
	wmdSub:refresh()

	AffVolets()

	Mode='V'
	genMenu()
end

function FermeVolets()
	wmdSub:clear()
	wmdSub:refresh()

	Mode=''
	genMenu()

	actWnd = nil
end

swinLst['V'] = { titre="&Volets", func=initVolets, key=keyVolets, close=FermeVolets }


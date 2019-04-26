function FermeAuto()
	wmdSub:clear()
	wmdSub:refresh()

	Mode=''
	genMenu()

	actWnd = nil
end


function initAuto()
	local x,y
	Mode='M'

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

	wmdSub:Move(2,3)
	wmdSub:print('Suivi solaire : ')
	x,y = wmdSub:GetXY()
	SuiviSol = wmdSub:DerWin(x,y,25,1)
	SuiviSol:attrset( SelCurses.CharAttrConst('BOLD') )
	updateSuiviSol()

	wmdSub:refresh()
	genMenu()
end

function keyAuto(Brk, c,cn)
end

swinLst['M'] = { titre="&Majordome", func=initAuto, key=keyAuto, close=FermeAuto }

-- Topics

function updateSaison()
	if Mode == 'M' then
		Saison:clear()
		Saison:print(SelShared.Get('Majordome/Saison'))
		Saison:refresh()
	end
end

function updateSaisonH()
	if Mode == 'M' then
		SaisonH:clear()
		SaisonH:print(SelShared.Get('Majordome/Saison/Hier'))
		SaisonH:refresh()
	end
end

function updateModeR()
	if Mode == 'M' then
		ModeR:clear()
		ModeR:print(SelShared.Get('Majordome/Mode'))
		ModeR:refresh()
	end
end

function updateSuiviSol()
	if Mode == 'M' then
		SuiviSol:clear()
		local r = SelShared.Get('Majordome/Traces/SuiviCoucherSoleil')
		if r ~= nil then
			if r:byte() == 70 then -- 'F'
				local h,m,hd,md = r:match( "(%d+):(%d+);(%d+):(%d+)" )
				SuiviSol:print( string.format("Fini a %02d:%02d contre %02d:%d02d", h,m, hd, md) )
			elseif r:byte() == 68 then -- 'D'
				local h,m = r:match( "(%d+):(%d+)" )
				SuiviSol:print( string.format("Debut a %02d:%02d", h,m) )
			elseif r:byte() == 69 then -- 'D'
				local h,m = r:match( "(%d+):(%d+)" )
				SuiviSol:print( string.format("Depuis %02d:%02d", h,m) )
			end
		end
		SuiviSol:refresh()
	end
end

local ltopics = {
	{ topic = 'Majordome/Saison', trigger=updateSaison, trigger_once=true },
	{ topic = 'Majordome/Saison/Hier', trigger=updateSaisonH, trigger_once=true },
	{ topic = 'Majordome/Mode', trigger=updateModeR, trigger_once=true },
	{ topic = 'Majordome/Traces/SuiviCoucherSoleil', trigger=updateSuiviSol, trigger_once=true },
}
TableMerge( Topics, ltopics)

-- Valeurs par défauts (pour éviter un crash si elle ne sont pas définies)

SelShared.Set('Majordome/Saison', '?')
SelShared.Set('Majordome/Saison/Hier', '?')
SelShared.Set('Majordome/Mode', '?')


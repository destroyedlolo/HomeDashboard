------
-- Helpers functions
------

-- merge t2 in t1
function TableMerge( t1, t2 )
	for _,v in ipairs(t2) do
		table.insert(t1, v)
	end

	return t1
end

-- GFX
function genTitre(w, s)
	local sub=false;
	for c in s:gmatch(".") do 
		if c == '&' then
			sub = true;
			w:attron( SelCurses.CharAttrConst("UNDERLINE") )
		else 
			w:addch(c)
			if sub then
				sub = false;
				w:attroff( SelCurses.CharAttrConst("UNDERLINE") )
			end
		end
	end
end

function genMenu()
	wndMenu:clear()
	for _,w in pairs(swinLst) do
		if Mode==_ then
			wndMenu:attrset( SelCurses.CharAttrConst("REVERSE") )
		end
		wndMenu:addch('[')
		genTitre(wndMenu, w.titre)
		wndMenu:addch(']')
		if Mode==_ then
			wndMenu:attrset( SelCurses.CharAttrConst("NORMAL") )
		end
	end
	wndMenu:refresh()
end


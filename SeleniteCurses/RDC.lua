-- This file define the window related to the "rez-de-chaussée"
local x,y

pwnd:print("\nDehors: ")
x,y = pwnd:GetXY()
TDehors = pwnd:DerWin(x,y,5,1)
TDehors:attrset( SelCurses.CharAttrConst("BOLD") )
pwnd:print(" ??.?°C,  Salon: ")
x,y = pwnd:GetXY()
TSalon = pwnd:DerWin(x,y,5,1)
TSalon:attrset( SelCurses.CharAttrConst("BOLD") )
pwnd:print(" ??.?°C,  Bureau: ")
x,y = pwnd:GetXY()
TBureau = pwnd:DerWin(x,y,5,1)
TBureau:attrset( SelCurses.CharAttrConst("BOLD") )
pwnd:print(" ??.?°C")

function updateTDehors()
	TDehors:clear()
	TDehors:print( string.format("%4.1f", SelShared.get('maison/Temperature/Dehors')) )
	TDehors:refresh()
end

function updateTSalon()
	TSalon:clear()
	TSalon:print( string.format("%4.1f", SelShared.get('maison/Temperature/Salon')) )
	TSalon:refresh()
end

function updateTBureau()
	TBureau:clear()
	TBureau:print( string.format("%4.1f", SelShared.get('maison/Temperature/Bureau')) )
	TBureau:refresh()
end


-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Dehors", trigger=updateTDehors, trigger_once=true },
	{ topic = "maison/Temperature/Salon", trigger=updateTSalon, trigger_once=true },
	{ topic = "maison/Temperature/Bureau", trigger=updateTBureau, trigger_once=true },
}

TableMerge( Topics, ltopics)


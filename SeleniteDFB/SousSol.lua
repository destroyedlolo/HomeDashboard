-- This file define the window related to the basement "Sous sol"

-- valeur par défaut
SelShared.set('Majordome/HLever', 8.0 )
SelShared.set('Majordome/HCoucher', 21.3 )

-- Graphismes

local window = layer:CreateWindow {
	pos = WINTOP, size = WINSIZE,
	caps=SelWindow.CapsConst('NONE'),
	surface_caps=SelSurface.CapabilityConst('NONE')
}
window:SetOpacity(0xff)			-- Make it visible
ss_srf = window:GetSurface()	-- Get its surface

table.insert( winlist, window )

-- compatibility with newer Lua
local unpack = unpack or table.unpack

-- Design

ss_srf:SetColor( unpack(COL_BORDER) )
ss_srf:SetFont( ftitle )
ss_srf:DrawString("Sous sol", 0, 0)
local goffx = ftitle:StringWidth("Sous sol") + 55

local img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/SousSol.png")
assert(img)
local tx,ty = ss_srf:GetSize()
img:RenderTo( ss_srf, { 20,50, tx-150, ty-150 } )
img:destroy()	-- The image is not needed anymore

srf_TGarage = ss_srf:SubSurface( 360, 280, fdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TGarage:SetColor( unpack(COL_BLACK) )
srf_TGarage:SetFont( fdigit )

srf_TGarageP = ss_srf:SubSurface( 30, 280, fdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TGarageP:SetColor( unpack(COL_BLACK) )
srf_TGarageP:SetFont( fdigit )

srf_SGarageP = ss_srf:SubSurface( 30, 190, fmdigit:StringWidth("Verrouillee"), fmdigit:GetHeight() )
srf_SGarageP:SetFont( fmdigit )

ss_srf:SetFont( ftitle1 )
ss_srf:SetColor( unpack(COL_TITLE) )
ss_srf:DrawString("Congélateur :", goffx, ftitle:GetHeight() - ftitle1:GetHeight() )
goffx = goffx + ftitle1:StringWidth("Congélateur :") + 10

srf_TCongelo = ss_srf:SubSurface( goffx, ftitle:GetHeight() - fmdigit:GetHeight(), fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight()  )
srf_TCongelo:SetFont( fmdigit)

local goffy = 0
goffx = tx-120

ss_srf:SetColor( unpack(COL_BORDER) )
ss_srf:SetFont( ftitle )
ss_srf:DrawString("Enfants", goffx, goffy)
goffy = goffy + ftitle:GetHeight()

ss_srf:SetFont( ftitle1 )
ss_srf:SetColor( unpack(COL_TITLE) )
ss_srf:DrawString("Heure du Levé :", goffx, goffy )
goffy = goffy + ftitle1:GetHeight()

srf_CLeve = ss_srf:SubSurface( goffx+20, goffy, fmdigit:StringWidth("88:88"), fmdigit:GetHeight()  )
srf_CLeve:SetFont( fmdigit)
srf_CLeve:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fmdigit:GetHeight() + 5

ss_srf:DrawString("Heure du Couché :", goffx, goffy )
goffy = goffy + ftitle1:GetHeight()

srf_CCouche = ss_srf:SubSurface( goffx+20, goffy, fmdigit:StringWidth("88:88"), fmdigit:GetHeight()  )
srf_CCouche:SetFont( fmdigit)
srf_CCouche:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fmdigit:GetHeight() + 5

ss_srf:DrawLine( goffx + 30, goffy, tx - 30, goffy )
goffy = goffy + 5

ss_srf:SetColor( unpack(COL_BORDER) )
ss_srf:SetFont( ftitle )
ss_srf:DrawString("Soleil", goffx, goffy)
goffy = goffy + ftitle:GetHeight()

ss_srf:SetFont( ftitle1 )
ss_srf:SetColor( unpack(COL_TITLE) )

ss_srf:DrawString("Heure du Levé :", goffx, goffy )
goffy = goffy + ftitle1:GetHeight()

srf_SLeve = ss_srf:SubSurface( goffx+20, goffy, fmdigit:StringWidth("88:88"), fmdigit:GetHeight()  )
srf_SLeve:SetFont( fmdigit)
srf_SLeve:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fmdigit:GetHeight() + 5

ss_srf:DrawString("Heure du Couché :", goffx, goffy )
goffy = goffy + ftitle1:GetHeight()

srf_SCouche = ss_srf:SubSurface( goffx+20, goffy, fmdigit:StringWidth("88:88"), fmdigit:GetHeight()  )
srf_SCouche:SetFont( fmdigit)
srf_SCouche:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fmdigit:GetHeight() + 5

ss_srf:DrawString("Saison :", goffx, goffy )
goffy = goffy + ftitle1:GetHeight()

srf_Saison = ss_srf:SubSurface( goffx-15, goffy, fmdigit:StringWidth("Intersaison"), fmdigit:GetHeight()  )
srf_Saison:SetFont( fmdigit)
srf_Saison:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fmdigit:GetHeight() + 5

goffy = ty - 80
goffx = 20
local tmode = fmdigit:StringWidth("Vacances")

ss_srf:DrawString("Mode forcé :", goffx, goffy )
srf_ModeF = ss_srf:SubSurface( goffx, goffy + ftitle1:GetHeight(), tmode, fmdigit:GetHeight()  )
srf_ModeF:SetFont( fmdigit)
srf_ModeF:SetColor( unpack(COL_DIGIT) )

goffx = goffx + tmode + 30
ss_srf:DrawString("Mode forcé enfants:", goffx, goffy )
srf_ModeFE = ss_srf:SubSurface( goffx, goffy + ftitle1:GetHeight(), tmode, fmdigit:GetHeight()  )
srf_ModeFE:SetFont( fmdigit)
srf_ModeFE:SetColor( unpack(COL_DIGIT) )

goffx = goffx + ftitle1:StringWidth("Mode forcé enfants:")  + 30
ss_srf:DrawString("Mode actif:", goffx, goffy )
srf_Mode = ss_srf:SubSurface( goffx, goffy + ftitle1:GetHeight(), fdigit:StringWidth("Vacances"), fdigit:GetHeight()  )
srf_Mode:SetFont( fdigit)
srf_Mode:SetColor( unpack(COL_DIGIT) )

-- Update functions
function sssrfupdate()
	ss_srf:Flip(SelSurface.FlipFlagsConst("NONE"))
end

function updateTGarage()
	UpdDataRight( srf_TGarage, SelShared.get('maison/Temperature/Garage') .. "°C", { 26,123,23, 255 } )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTGarageP()
	UpdDataRight( srf_TGarageP, SelShared.get('maison/Temperature/GarageP') .. "°C", { 26,123,23, 255 } )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTCongelo()
	local cols = {
		[-18] = COL_DIGIT,
		[-15.5] = COL_GREEN,
		[-10] = COL_ORANGE,
		[0] = COL_RED
	}
	local v = SelShared.get('maison/Temperature/Congelateur')
	srf_TCongelo:SetColor( findgradiancolor(v, cols ) )

	UpdDataRight( srf_TCongelo, v .. "°C" )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateCLeve()
	UpdDataCentered( srf_CLeve, string.format("%02.02f", SelShared.get('Majordome/HLever')) )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateCCouche()
	UpdDataCentered( srf_CCouche, string.format("%02.02f", SelShared.get('Majordome/HCoucher')) )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updatePorteGarage()
	local v = SelShared.get('maison/IO/Porte_Garage')

	srf_SGarageP:Clear( 26,123,23, 255 )
	if v == 'Ouverte' then
		srf_SGarageP:SetColor( unpack(COL_ORANGED) )
	elseif v == 'Fermee' then
		srf_SGarageP:SetColor( unpack(COL_REDD) )
		v = 'Fermée'
	else
		srf_SGarageP:SetColor( unpack(COL_GREEND) )
		v = 'Verrouillée'
	end
	srf_SGarageP:DrawString(v, 0,0)
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateSaison()
	UpdDataCentered( srf_Saison, SelShared.get('Majordome/Saison') )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST") )
end

function updateMForce()
	UpdDataCentered( srf_ModeF, SelShared.get('Majordome/Mode/Force') )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST") )
end

function updateMEnfants()
	UpdDataCentered( srf_ModeFE, SelShared.get('Majordome/Mode/Enfants') )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST") )
end

function updateMode()
	UpdDataCentered( srf_Mode, SelShared.get('Majordome/Mode') )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST") )
end

function updateSLeve()
	UpdDataCentered( srf_SLeve, SelShared.get('Meteo/Nonglard/sunrise') )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST") )
end

function updateSCouche()
	UpdDataCentered( srf_SCouche, SelShared.get('Meteo/Nonglard/sunset') )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST") )
end

-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Garage", trigger=updateTGarage, trigger_once=true },
	{ topic = "maison/Temperature/GarageP", trigger=updateTGarageP, trigger_once=true },
	{ topic = "maison/Temperature/Congelateur", trigger=updateTCongelo, trigger_once=true },
	{ topic = "Majordome/HLever", trigger=updateCLeve, trigger_once=true },
	{ topic = "Majordome/HCoucher", trigger=updateCCouche, trigger_once=true },
	{ topic = "maison/IO/Porte_Garage", trigger=updatePorteGarage, trigger_once=true },
	{ topic = "Majordome/Saison", trigger=updateSaison, trigger_once=true },
	{ topic = "Majordome/Mode/Force", trigger=updateMForce, trigger_once=true },
	{ topic = "Majordome/Mode/Enfants", trigger=updateMEnfants, trigger_once=true },
	{ topic = "Majordome/Mode", trigger=updateMode, trigger_once=true },
	{ topic = "Meteo/Nonglard/sunrise", trigger=updateSLeve, trigger_once=true },
	{ topic = "Meteo/Nonglard/sunset", trigger=updateSCouche, trigger_once=true },
}

TableMerge( Topics, ltopics)

updateCLeve()
updateCCouche()
sssrfupdate()

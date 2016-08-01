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

local img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/SousSol.png")
assert(img)
local tx,ty = ss_srf:GetSize()
img:RenderTo( ss_srf, { 20,50, tx-150, ty-150 } )
img:destroy()	-- The image is not needed anymore

srf_TCave = ss_srf:SubSurface( 360, 280, fdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TCave:SetColor( unpack(COL_BLACK) )
srf_TCave:SetFont( fdigit )

srf_TCaveP = ss_srf:SubSurface( 30, 280, fdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TCaveP:SetColor( unpack(COL_BLACK) )
srf_TCaveP:SetFont( fdigit )

srf_SCaveP = ss_srf:SubSurface( 30, 190, fmdigit:StringWidth("Verrouillee"), fmdigit:GetHeight() )
srf_SCaveP:SetFont( fmdigit )

local goffx = tx-120
ss_srf:SetFont( ftitle1 )
ss_srf:SetColor( unpack(COL_TITLE) )
ss_srf:DrawString("Congélateur :", goffx, 45 )
local goffy = 45 + ftitle1:GetHeight()

srf_TCongelo = ss_srf:SubSurface( goffx+20, goffy, fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight()  )
srf_TCongelo:SetFont( fmdigit)
goffy = goffy + fmdigit:GetHeight() + 15

ss_srf:DrawLine( goffx + 30, goffy, tx - 30, goffy )
goffy = goffy + 15

ss_srf:DrawString("Heure du Levé :", goffx, goffy )
goffy = goffy + ftitle1:GetHeight()

srf_CLeve = ss_srf:SubSurface( goffx+20, goffy, fmdigit:StringWidth("88:88"), fmdigit:GetHeight()  )
srf_CLeve:SetFont( fmdigit)
srf_CLeve:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fmdigit:GetHeight() + 15

ss_srf:DrawString("Heure du Couché :", goffx, goffy )
goffy = goffy + ftitle1:GetHeight()

srf_CCouche = ss_srf:SubSurface( goffx+20, goffy, fmdigit:StringWidth("88:88"), fmdigit:GetHeight()  )
srf_CCouche:SetFont( fmdigit)
srf_CCouche:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fmdigit:GetHeight() + 15

ss_srf:DrawString("Saison :", goffx, goffy )
goffy = goffy + ftitle1:GetHeight()

srf_Saison = ss_srf:SubSurface( goffx-5, goffy, fmdigit:StringWidth("Intersaison"), fmdigit:GetHeight()  )
srf_Saison:SetFont( fmdigit)
srf_Saison:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fmdigit:GetHeight() + 15

--[[
goffy = ty - 130
goffx = 20
ss_srf:DrawString("Mode forcé :", goffx, 45 )
]]

-- Update functions
function sssrfupdate()
	ss_srf:Flip(SelSurface.FlipFlagsConst("NONE"))
end

function updateTCave()
	UpdDataRight( srf_TCave, SelShared.get('maison/Temperature/Cave') .. "°C", { 26,123,23, 255 } )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTCaveP()
	UpdDataRight( srf_TCaveP, SelShared.get('maison/Temperature/CaveP') .. "°C", { 26,123,23, 255 } )
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

function updatePorteCave()
	local v = SelShared.get('maison/IO/Porte_Cave')

	srf_SCaveP:Clear( 26,123,23, 255 )
	if v == 'Ouverte' then
		srf_SCaveP:SetColor( unpack(COL_ORANGED) )
	elseif v == 'Fermee' then
		srf_SCaveP:SetColor( unpack(COL_REDD) )
		v = 'Fermée'
	else
		srf_SCaveP:SetColor( unpack(COL_GREEND) )
		v = 'Verrouillée'
	end
	srf_SCaveP:DrawString(v, 0,0)
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateSaison()
	UpdDataCentered( srf_Saison, SelShared.get('Majordome/Saison') )
	SelShared.PushTask( sssrfupdate, SelShared.TaskOnceConst("LAST") )
end

-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Cave", trigger=updateTCave, trigger_once=true },
	{ topic = "maison/Temperature/CaveP", trigger=updateTCaveP, trigger_once=true },
	{ topic = "maison/Temperature/Congelateur", trigger=updateTCongelo, trigger_once=true },
	{ topic = "Majordome/HLever", trigger=updateCLeve, trigger_once=true },
	{ topic = "Majordome/HCoucher", trigger=updateCCouche, trigger_once=true },
	{ topic = "maison/IO/Porte_Cave", trigger=updatePorteCave, trigger_once=true },
	{ topic = "Majordome/Saison", trigger=updateSaison, trigger_once=true },
}

TableMerge( Topics, ltopics)

updateCLeve()
updateCCouche()
sssrfupdate()

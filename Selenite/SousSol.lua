-- This file define the window related to the basement "Sous sol"

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

local goffx = tx-120
ss_srf:SetFont( ftitle1 )
ss_srf:SetColor( unpack(COL_TITLE) )
ss_srf:DrawString("Congélateur :", goffx, 45 )
local goffy = 45 + ftitle1:GetHeight()

srf_TCongelo = ss_srf:SubSurface( goffx+20, goffy, fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight()  )
--srf_TCongelo:SetColor( unpack(COL_BLACK) )
srf_TCongelo:SetFont( fmdigit)

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


-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Cave", trigger=updateTCave, trigger_once=true },
	{ topic = "maison/Temperature/CaveP", trigger=updateTCaveP, trigger_once=true },
	{ topic = "maison/Temperature/Congelateur", trigger=updateTCongelo, trigger_once=true },
}

TableMerge( Topics, ltopics)

sssrfupdate()

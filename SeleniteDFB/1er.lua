-- This file define the window related to the "1st floor"

local window = layer:CreateWindow {
	pos = WINTOP, size = WINSIZE,
	caps=SelWindow.CapsConst('NONE'),
	surface_caps=SelSurface.CapabilityConst('NONE')
}
window:SetOpacity(0xff)			-- Make it visible
per_srf = window:GetSurface()	-- Get its surface

table.insert( winlist, window )

-- compatibility with newer Lua
local unpack = unpack or table.unpack

-- Design

per_srf:SetColor( unpack(COL_BORDER) )
per_srf:SetFont( ftitle )
per_srf:DrawString("1er étage", 0, 0)

per_srf:SetFont( ftitle1 )
per_srf:SetColor( unpack(COL_TITLE) )
per_srf:DrawString("Comble :", 200, 10)
srf_TComble = per_srf:SubSurface( 200 + ftitle1:StringWidth("Comble : "), 0, ftitle:StringWidth("-88.8°C"), ftitle:GetHeight() )
srf_TComble:SetColor( unpack(COL_DIGIT) )
srf_TComble:SetFont( ftitle )

local goffy = ftitle:GetHeight() + 10

local img,err = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/1er.png")
assert(img)
local tx,ty = per_srf:GetSize()
img:RenderTo( per_srf, { 20,50, tx-30, ty-70 } )
img:destroy()	-- The image is not needed anymore

srf_TGN = per_srf:SubSurface( 30, 200, 25 + fdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TGN:SetColor( unpack(COL_BLACK) )
srf_TGN:SetFont( fdigit )

srf_TchJ = per_srf:SubSurface( 175, 250, 25 + fdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TchJ:SetColor( unpack(COL_BLACK) )
srf_TchJ:SetFont( fdigit )

srf_TchO = per_srf:SubSurface( 330, 250, 25 + fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TchO:SetColor( unpack(COL_BLACK) )
srf_TchO:SetFont( fdigit )

srf_TGS = per_srf:SubSurface( 475, 200, 25 + fdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TGS:SetColor( unpack(COL_BLACK) )
srf_TGS:SetFont( fdigit )

-- Update functions
function presrfupdate()
	per_srf:Flip(SelSurface.FlipFlagsConst("NONE"))
end

function updateTGrN()
	UpdDataRight( srf_TGN, SelShared.get('maison/Temperature/Grenier Nord') .. "°C", { 28,104,28, 255 } )
	SelShared.PushTask( presrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTGrS()
	UpdDataRight( srf_TGS, SelShared.get('maison/Temperature/Grenier Sud') .. "°C", { 76,118,34, 255 } )
	SelShared.PushTask( presrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTChJ()
	UpdDataRight( srf_TchJ, SelShared.get('maison/Temperature/Chambre Joris') .. "°C", { 64,65,19, 255 } )
	SelShared.PushTask( presrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTChO()
	UpdDataRight( srf_TchO, SelShared.get('maison/Temperature/Chambre Oceane') .. "°C", { 64,85,181, 255 } )
	SelShared.PushTask( presrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTComble()
	UpdDataRight( srf_TComble, SelShared.get('maison/Temperature/Comble') .. "°C")
	SelShared.PushTask( presrfupdate, SelShared.TaskOnceConst("LAST"))
end

-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Grenier Nord", trigger=updateTGrN, trigger_once=true },
	{ topic = "maison/Temperature/Grenier Sud", trigger=updateTGrS, trigger_once=true },
	{ topic = "maison/Temperature/Chambre Joris", trigger=updateTChJ, trigger_once=true },
	{ topic = "maison/Temperature/Chambre Oceane", trigger=updateTChO, trigger_once=true },
	{ topic = "maison/Temperature/Comble", trigger=updateTComble, trigger_once=true }
}

TableMerge( Topics, ltopics)

presrfupdate()

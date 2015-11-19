-- This file define the window related to the "rez-de-chaussée"

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

local goffy = ftitle:GetHeight() + 10

local img,err = SelImage.create("Selenite/Images/1er.png")
assert(img)
local tx,ty = per_srf:GetSize()
img:RenderTo( per_srf, { 20,50, tx-30, ty-70 } )
img:destroy()	-- The image is not needed anymore

srf_TGN = per_srf:SubSurface( 40, 200, 25 + fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TGN:SetColor( unpack(COL_BLACK) )
srf_TGN:SetFont( fmdigit )
srf_TGN:Clear( 50,50,50,255 )

srf_TchJ = per_srf:SubSurface( 185, 250, 25 + fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TchJ:SetColor( unpack(COL_BLACK) )
srf_TchJ:SetFont( fmdigit )
srf_TchJ:Clear( 50,50,50,255 )

srf_TchO = per_srf:SubSurface( 340, 250, 25 + fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TchO:SetColor( unpack(COL_BLACK) )
srf_TchO:SetFont( fmdigit )
srf_TchO:Clear( 50,50,50,255 )

-- Update functions
function presrfupdate()
	per_srf:Flip(SelSurface.FlipFlagsConst("NONE"))
end

function updateTGrN()
	UpdDataRight( srf_TGN, SelShared.get('maison/Temperature/Grenier Nord') .. "°C", { 28,104,28, 255 } )
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

-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Grenier Nord", trigger=updateTGrN, trigger_once=true },
	{ topic = "maison/Temperature/Chambre Joris", trigger=updateTChJ, trigger_once=true },
	{ topic = "maison/Temperature/Chambre Oceane", trigger=updateTChO, trigger_once=true },

}

TableMerge( Topics, ltopics)

presrfupdate()

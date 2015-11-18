-- This file define the window related to the "rez-de-chaussée"

local window = layer:CreateWindow {
	pos = WINTOP, size = WINSIZE,
	caps=SelWindow.CapsConst('NONE'),
	surface_caps=SelSurface.CapabilityConst('NONE')
}
window:SetOpacity(0xff)			-- Make it visible
rdc_srf = window:GetSurface()	-- Get its surface

table.insert( winlist, window )

-- compatibility with newer Lua
local unpack = unpack or table.unpack

-- Design

rdc_srf:SetColor( unpack(COL_BORDER) )
rdc_srf:SetFont( ftitle )
rdc_srf:DrawString("Rez-de-chaussée", 0, 0)

local goffy = ftitle:GetHeight() + 10

local img,err = SelImage.create("Selenite/Images/RDC.png")
assert(img)
local tx,ty = rdc_srf:GetSize()
img:RenderTo( rdc_srf, { 10,40, tx-20, ty-60 } )
img:destroy()	-- The image is not needed anymore

srf_TBureau = rdc_srf:SubSurface( 20, 290, 25 + fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TBureau:SetColor( unpack(COL_BLACK) )
srf_TBureau:SetFont( fmdigit )

srf_TCSalon = rdc_srf:SubSurface( 185, 290, 15 + fmdigit:StringWidth("-88.8°C"), fmdigit:GetHeight() )
srf_TCSalon:SetColor( unpack(COL_BLACK) )
srf_TCSalon:SetFont( fmdigit )

-- Update functions
function rdcsrfupdate()
	rdc_srf:Flip(SelSurface.FlipFlagsConst("NONE"))
end

function updateTSalon()
	local v = SelShared.get('maison/Temperature/Salon')

		-- Update on the card
	UpdDataRight( srf_TCSalon, v .. "°C", { 25,112,133, 255 } )
	SelShared.PushTask( rdcsrfupdate, SelShared.TaskOnceConst("LAST"))

		-- Update on the primary surface
	srf_TSalon:SetColor( findgradiancolor(v, cols_temperature ) )
	upddata( srf_TSalon, fdigit, v .. "°C" )
	SelShared.PushTask( psrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTDehors()
		-- Update on the primary surface
	upddata( srf_TDehors, fdigit, SelShared.get('maison/Temperature/Dehors') .. "°C" )
	SelShared.PushTask( psrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updateTBureau()
	UpdDataRight( srf_TBureau, SelShared.get('maison/Temperature/Bureau') .. "°C", { 96,66,18, 255 } )
	SelShared.PushTask( rdcsrfupdate, SelShared.TaskOnceConst("LAST"))
end

-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Salon", trigger=updateTSalon, trigger_once=true },
	{ topic = "maison/Temperature/Dehors", trigger=updateTDehors, trigger_once=true },
	{ topic = "maison/Temperature/Bureau", trigger=updateTBureau, trigger_once=true },
}

TableMerge( Topics, ltopics)

rdcsrfupdate()

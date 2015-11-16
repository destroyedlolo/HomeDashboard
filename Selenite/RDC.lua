-- This file define the window related to the "rez-de-chaussée"

local window = layer:CreateWindow {
	pos = WINTOP, size = WINSIZE,
	caps=SelWindow.CapsConst('NONE'),
	stacking=SelWindow.StackingConst("UPPER"),
	surface_caps=SelSurface.CapabilityConst('NONE')
}
window:SetOpacity(0xff)			-- Make it visible
rdc_srf = window:GetSurface()	-- Get its surface

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
img:RenderTo( rdc_srf, { 10,40, tx-80, ty-70 } )
img:destroy()	-- The image is not needed anymore


-- Update functions
function updateTSalon()
	local v = SelShared.get('maison/Temperature/Salon')

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

function rdcsrfupdate()
	rdc_srf:Flip(SelSurface.FlipFlagsConst("NONE"))
end

-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Salon", trigger=updateTSalon, trigger_once=true },
	{ topic = "maison/Temperature/Dehors", trigger=updateTDehors, trigger_once=true },
}

TableMerge( Topics, ltopics)

rdcsrfupdate()

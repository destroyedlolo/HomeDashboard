-- This file define the window related to the "rez-de-chaussée"

local window = layer:CreateWindow {
	pos = WINTOP, size = WINSIZE,
	caps=SelWindow.CapsConst('NONE'),
	stacking=SelWindow.StackingConst("UPPER"),
	surface_caps=SelSurface.CapabilityConst('NONE')
}
window:SetOpacity(0xff)			-- Make it visible
rdc_srf = window:GetSurface()	-- Get its surface

rdc_srf:Clear(60,60,60,100)
rdc_srf:Flip(SelSurface.FlipFlagsConst("NONE"))

-- compatibility with newer Lua
local unpack = unpack or table.unpack

-- Update functions
function updateTSalon()
	local v = SelShared.get('maison/Temperature/Salon')

		-- Update on the primary surface
	srf_TSalon:SetColor( findgradiancolor(v, cols_temperature ) )
	upddata( srf_TSalon, fdigit, v .. "°C" )
end

function updateTDehors()
		-- Update on the primary surface
	upddata( srf_TDehors, fdigit, SelShared.get('maison/Temperature/Dehors') .. "°C" )
end

-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Salon", trigger=updateTSalon, trigger_once=true },
	{ topic = "maison/Temperature/Dehors", trigger=updateTDehors, trigger_once=true },
}

TableMerge( Topics, ltopics)


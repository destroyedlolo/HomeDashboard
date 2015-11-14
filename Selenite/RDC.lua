-- This file define the window related to the "rez-de-chaussée"

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


-- Weather forcast
local function meteo()
	local self = {}

	local window = layer:CreateWindow {
		pos = WINTOP, size = WINSIZE,
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	}
	window:SetOpacity(0xff)	-- Make the window visible
	table.insert( winlist, window )
	local srf = window:GetSurface()

	local currentw = cweather( srf, 0,0 )
	local w0 = Weather3H(currentw, 'Meteo3H', 'Nonglard', 0)

	local plus1 = stweather( srf, 0, currentw.getBellow() )
	local w1 = Weather3H(plus1, 'Meteo3H', 'Nonglard', 1)

	local plus2 = stweather( srf, plus1.getNext() + 5, currentw.getBellow() )
	local w2 = Weather3H(plus2, 'Meteo3H', 'Nonglard', 2)

	local plus3 = stweather( srf, plus2.getNext() + 5, currentw.getBellow() )
	local w3 = Weather3H(plus3, 'Meteo3H', 'Nonglard', 3)

		-- refresh window's content
	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Meteo = meteo()

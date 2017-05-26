-- Energy saving
local function energy()
	local self = {}

	local window = layer:CreateWindow {
		pos = WINTOP, size = WINSIZE,
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE'),
	}
	window:SetOpacity(0xff)	-- Make the window visible
	table.insert( winlist, window )
	local srf = window:GetSurface()

	srf:SetColor( COL_TITLE.get() )
	srf:SetFont( ftitle )
	srf:DrawString("Econnomies d'énergie", 0, 0)

	cdt = MQTTCounterStatGfx(srf,
		'Stat mensuelle', 'Domestik/Electricite/Mensuel', 
		35, ftitle:GetHeight()+10, 350,250, {
			bordercolor = COL_GREY ,
			consumption_border = COL_ORANGED,
			production_border = COL_GREEND
		} 
	)

	return self
end

Energy = energy()

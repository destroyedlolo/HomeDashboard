-- Top config menu

function ConfigMenu()
	local self = {}

	local window = layer:CreateWindow {
		pos = {300,50}, size = {250,150},
		stacking = SelWindow.StackingConst('UPPER'),
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	}
	window:SetOpacity(0xff)	-- Make the window visible
	local wsrf = window:GetSurface()

	wsrf:Clear( 0,0,0, 0x90 )
	wsrf:SetColor( COL_TITLE.get() )
	wsrf:SetFont( ftitle1 )
	wsrf:DrawString("Configuration", 3, 3)
	wsrf:DrawRectangle(0,0, 250,150)

		-- refresh window's content
	wsrf:Flip(SelSurface.FlipFlagsConst("NONE"))

print("ConfigMenu()")
Selene.Sleep(2)
window:Release()

	return self
end

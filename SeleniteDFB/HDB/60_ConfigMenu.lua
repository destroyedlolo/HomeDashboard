-- Top config menu

-- Unlike in other source files, this is not an object :
-- This function creates the windows (and sub object) and then everything
-- is managed through keys' actions.

function ConfigMenu()
	local self = {}
	local oldKA = keysactions	-- Keep old key mapping

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

		-- Keys handling
	function self.bye()
		keysactions = oldKA		-- Restore old keys mapping
		window:Release()
	end

	keysactions = {
		['KEY/POWER/1'] = self.bye
	}

	return self
end

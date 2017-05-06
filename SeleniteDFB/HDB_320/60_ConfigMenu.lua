-- Top config menu

-- Unlike in other source files, this is not an object :
-- This function creates the windows (and sub object) and then everything
-- is managed through keys' actions.

function ConfigMenu()
	local popup = PopUp( {
		pos = {30,20}, size = {150,150},
		stacking = SelWindow.StackingConst('UPPER'),
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	},
	{
		keysactions = 'keysactions',	-- Active keysactions table
	})

	popup.setKeysActions { 
			['KEY/POWER/1'] = popup.close
	}
end

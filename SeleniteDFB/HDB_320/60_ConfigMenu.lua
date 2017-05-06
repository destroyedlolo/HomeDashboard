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
		bordercolor = COL_LIGHTGREY
	})

	popup.setColor( COL_WHITE )
	popup.get():SetFont( ftitle1 )
	popup.get():DrawString("Configuration", 0,0)
	popup.refresh()

	local lst = vsList( popup, 
		0, ftitle1:GetHeight() + 15, popup.get():GetWidth(),
		{
			{ 'Mode générale', nil },
			{ ' > Mode Enfants', nil },
			{ ' > > Mode Oceane', nil },
			{ ' > > Mode Joris', nil },
			{ ' > Mode Parents', nil }
		},
		fmdigit,
		{
			unselcolor = COL_TITLE,
			selcolor = COL_DIGIT
		}
	)

	popup.setKeysActions {
			['KEY/VOLUMEDOWN/1'] = lst.selprev,
			['KEY/VOLUMEUP/1'] = lst.selnext,
			['KEY/POWER/1'] = popup.close
	}

end

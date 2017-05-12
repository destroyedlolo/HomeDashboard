-- Top config menu

-- Unlike in other source files, this is not an object :
-- This function creates the windows (and sub object) and then everything
-- is managed through keys' actions.

function ModeMenu( parent )
	local menu = Menu( {
		pos = {320,70},
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	},
	{
		{ 'Mode générale', nil },
		{ ' > Mode Enfants', nil },
		{ ' > > Mode Oceane', nil },
		{ ' > > Mode Joris', nil },
		{ ' > Mode Parents', nil }
	}, -- list
	fmenu,
	{
		keysactions = 'keysactions',	-- Active keysactions table
		bordercolor = COL_LIGHTGREY,

		title = 'Configuration',
		titlefont = ftitle1,
		titlecolor = COL_WHITE,

		unselcolor = COL_TITLE,
		selcolor = COL_DIGIT,

		userdata = parent
	})

	menu.setKeysActions {
			['KEY/VOLUMEDOWN/1'] = menu.selnext,
			['KEY/VOLUMEUP/1'] = menu.selprev,
			['KEY/POWER/1'] = menu.close
	}

end

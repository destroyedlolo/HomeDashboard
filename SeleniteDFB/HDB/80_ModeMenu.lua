-- Top config menu

-- Unlike in other source files, this is not an object :
-- This function creates the windows (and sub object) and then everything
-- is managed through keys' actions.

-- LF: Les topics ne sont pas bon, ca devrait être les "Force" et non les actifs

function ModeMenu( parent )
	local menu = Menu( {
		pos = {300,70},
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	},
	{
		{ 'Mode générale', nil },
		{ ' > Mode Enfants', nil },
		{ ' > > Mode Oceane', function () ModeItem('Mode Océane', 'Majordome/Mode/Oceane') end },
		{ ' > > Mode Joris', nil },
		{ ' > Mode Parents', function () ModeItem('Mode Parents', 'Majordome/Mode/Parents') end }
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
			['KEY/POWER/1'] = menu.close,
			['KEY/SEARCH/1'] = menu.action
	}

end

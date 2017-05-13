-- Mode configuration menu

-- Unlike in other source files, this is not an object :
-- This function creates the windows (and sub object) and then everything
-- is managed through keys' actions.

function ModeMenu( parent )
	local menu = Menu( {
		pos = {40,30},
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	},
	{
		{ 'Mode générale', function () ModeItem('Mode générale', 'Majordome/Mode/Force') end },
		{ ' > Mode Enfants', function () ModeItem('Mode Enfants', 'Majordome/Mode/Force/Enfants') end },
		{ ' > > Mode Oceane', function () ModeItem('Mode Océane', 'Majordome/Mode/Force/Enfants/Oceane') end },
		{ ' > > Mode Joris', function () ModeItem('Mode Joris', 'Majordome/Mode/Force/Enfants/Joris') end },
		{ ' > Mode Parents', function () ModeItem('Mode Parents', 'Majordome/Mode/Force/Parents') end }
	}, -- list
	fmdigit,
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

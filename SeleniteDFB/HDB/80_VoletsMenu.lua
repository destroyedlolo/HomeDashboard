-- Rolling shutter menu

function VoletsMenu( parent )
		local menu = Menu( {
		pos = {300,70},
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	},
	{
		{ 'Chambre Océane', nil },
		{ 'Chambre Joris', nil },
		{ 'Chambre Parents', nil },
		{ 'Cheminée', nil },
		{ 'Salon', nil },
		{ 'Balcon', nil },
		{ 'Bureau', nil },
		{ 'Chambre Amis', nil },
		{ 'Cuisine', nil },
		{ 'Chat', nil },
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

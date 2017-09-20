-- Rolling shutter menu

function VoletsMenu( parent )
		local menu = Menu( {
		pos = {300,70},
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	},
	{
		{ 'Chambre Océane', function () ActionVolet('Chambre Océane', 'maison/Volet/chOceane') end },
		{ 'Chambre Joris', function () ActionVolet('Chambre Joris', 'maison/Volet/chJoris') end },
		{ 'Chambre Parents', function () ActionVolet('Chambre Parents', 'maison/Volet/chParents') end },
		{ 'Cheminée', function () ActionVolet('Cheminée', 'maison/Volet/Salon/Cheminee') end },
		{ 'Salon', function () ActionVolet('Salon', 'maison/Volet/Salon/Fenetre') end },
		{ 'Balcon', function () ActionVolet('Balcon', 'maison/Volet/Salon/Balcon') end },
		{ 'Bureau', function () ActionVolet('Bureau', 'maison/Volet/Buro') end },
		{ 'Chambre Amis', function () ActionVolet('Chambre Amis', 'maison/Volet/chAmis') end },
		{ 'Cuisine', function () ActionVolet('Cuisine', 'maison/Volet/Cuisine/Fenetre') end },
		{ 'Chat', function () ActionVolet('Chat', 'maison/Volet/Cuisine/Chat') end },
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

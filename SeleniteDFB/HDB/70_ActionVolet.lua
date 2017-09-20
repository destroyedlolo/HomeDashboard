-- Actions for shutters

function ActionVolet( titre, topic, y )
	local menu = Menu( {
		pos = {320,y},
	}, {
		{ 'Haut & Bas' },
		{ 'Select = My' },
	},
	fmenu,
	{
		keysactions = 'keysactions',	-- Active keysactions table
		bordercolor = COL_LIGHTGREY,

		title = titre,
		titlefont = ftitle1,
		titlecolor = COL_WHITE,

		unselcolor = COL_TITLE,
		selcolor = COL_TITLE,

		userdata = parent
	})

	menu.setKeysActions {
		['KEY/VOLUMEDOWN/1'] = function () print 'bas' end,
		['KEY/VOLUMEUP/1'] = function () print 'haut' end,
		['KEY/POWER/1'] = menu.close,
		['KEY/SEARCH/1'] = function () print 'My' end,
	}

end

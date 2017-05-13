-- Mode's Items sub menu

function ModeItem( titre, topic, y )
-- topic : topic to send value
-- y : position of this sub menu
	local menu = Menu( {
		pos = {320,y},
	},
	{
		{ 'Auto', nil },
		{ 'Manuel', nil },
		{ 'Travail', nil },
		{ 'Vacances', nil },
		{ 'Absent', nil },
	}, -- list
	fmenu,
	{
		keysactions = 'keysactions',	-- Active keysactions table
		bordercolor = COL_LIGHTGREY,

		title = titre,
		titlefont = ftitle1,
		titlecolor = COL_WHITE,

		unselcolor = COL_TITLE,
		selcolor = COL_DIGIT,
		default = SelShared.get(topic),

		userdata = parent
	})

	menu.setKeysActions {
			['KEY/VOLUMEDOWN/1'] = menu.selnext,
			['KEY/VOLUMEUP/1'] = menu.selprev,
			['KEY/POWER/1'] = menu.close
	}

end

-- Mode's Items sub menu

function ModeItem( titre, topic, y )
-- topic : topic to send value
-- y : position of this sub menu
	local menu = Menu( {
		pos = {320,y},
	},
	{
		{ 'Auto', function () Brk:Publish( topic, 'Auto', true ) end },
		{ 'Manuel', function () Brk:Publish( topic, 'Manuel', true ) end },
		{ 'Travail', function () Brk:Publish( topic, 'Travail', true ) end },
		{ 'Vacances', function () Brk:Publish( topic, 'Vacances', true ) end },
		{ 'Absent', function () Brk:Publish( topic, 'Absent', true ) end },
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
		default = SelShared.Get(topic),

		userdata = parent
	})

	menu.setKeysActions {
		['KEY/VOLUMEDOWN/1'] = menu.selnext,
		['KEY/VOLUMEUP/1'] = menu.selprev,
		['KEY/POWER/1'] = menu.close,
		['KEY/SEARCH/1'] = menu.action
	}

end

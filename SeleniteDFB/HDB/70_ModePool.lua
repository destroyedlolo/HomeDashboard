-- Pool's modes sub menu

function ModePool( titre, topic, y )
-- topic : topic to send value
-- y : position of this sub menu
	local menu = Menu( {
		pos = {350,y},
	},
	{
		{ 'Heures Creuses', function () Brk:Publish( topic, 'Heures Creuses', true ) end },
		{ 'Arret', function () Brk:Publish( topic, 'Arret', true ) end },
		{ 'Forcé', function () Brk:Publish( topic, 'Forcé', true ) end },
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


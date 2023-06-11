-- Pool's modes sub menu

-- As this information is not displayed anywhere, we need this MQTTinput
-- to keep the actual value
modepiscine = MQTTinput('Majordome/Mode/Piscine', 'Majordome/Mode/Piscine')

function ModePool( titre, topic, y )
-- topic : topic to send value
-- y : position of this sub menu
	local menu = Menu( {
		pos = {50,y},
	},
	{
		{ 'Heures Creuses', function () Brk:Publish( topic, 'Heures Creuses', true ) end },
		{ 'Canicule', function () Brk:Publish( topic, 'Canicule', true ) end },
		{ 'Arret', function () Brk:Publish( topic, 'Arret', true ) end },
		{ 'Forcé', function () Brk:Publish( topic, 'Forcé', true ) end },
	}, -- list
	fmdigit,
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


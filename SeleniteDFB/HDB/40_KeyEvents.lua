-- Manage key events

-- Actions

function handleevent( tp, c, v )
	if SelEvent.TypeName(tp) == 'KEY' and v == 1 then
		if SelEvent.KeyName(c) == 'VOLUMEDOWN' then
			prevWindow( true )
		elseif SelEvent.KeyName(c) == 'VOLUMEUP' then
			nextWindow( true )
		elseif SelEvent.KeyName(c) == 'SEARCH' then
			Notification.Log('Not implemented ... yet')
		end
	end
end


-- Keys' event

local evt

local function handlekeys()
	local t, tp, c, v = evt:read()

	handleevent( tp, c, v )
end

evt = SelEvent.create('/dev/input/event1', handlekeys)
table.insert( additionnalevents, evt )


-- Fake keys

local function handlefakekeys()
	local t = SelEvent.TypeConst("KEY")

	if SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'VolD' then -- simulate VOLUMEDOWN
		handleevent( t, SelEvent.KeyConst("VOLUMEDOWN"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'VolU' then -- simulate VOLUMEUP
		handleevent( t, SelEvent.KeyConst("VOLUMEUP"), 1 )
	end
end

table.insert( Topics, 
	{ topic = 'HomeDashBoard/'.. MQTT_ClientID ..'/Key', trigger=handlefakekeys }
)
SelLog.log("*I* Listening on topic : HomeDashBoard/".. MQTT_ClientID ..'/Keys')

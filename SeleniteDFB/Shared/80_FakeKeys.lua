-- Simulates keys hit using MQTT messaging
-- (mainly for testing purposes ...)

local function handlefakekeys()
	local t = SelEvent.TypeConst("KEY")

	if SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'VolD' then -- simulate VOLUMEDOWN
		handleevent( 0, t, SelEvent.KeyConst("VOLUMEDOWN"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'VolU' then -- simulate VOLUMEUP
		handleevent( 0, t, SelEvent.KeyConst("VOLUMEUP"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'S' then -- simulate SEARCH
		handleevent( 0, t, SelEvent.KeyConst("SEARCH"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'Pwr' then -- simulate POWER
		handleevent( 0, t, SelEvent.KeyConst("POWER"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'Quit' then -- simulate POWER
		handleevent( 0, t, SelEvent.KeyConst("EJECTCD"), 1 )
	end
end

table.insert( Topics, 
	{ topic = 'HomeDashBoard/'.. MQTT_ClientID ..'/Key', trigger=handlefakekeys }
)
SelLog.log("*I* Listening on topic : HomeDashBoard/".. MQTT_ClientID ..'/Key')


function Command(topic, msg)
	local cmd = topic:match(".*/(.*)")
	local func = SelShared.FindRef( cmd )
	if func then
		SelShared.PushTaskByRef( func )
	end
end

SelLog.log('C', 'Command topic : "HomeDashBoard/'.. MQTT_ClientID .. '/#"')
SelLog.log('C', '"HomeDashBoard/'.. MQTT_ClientID .. '/Help" for supported topics list')
table.insert( Topics, 
	{ topic = 'HomeDashBoard/'.. MQTT_ClientID ..'/#', func=Command }
)


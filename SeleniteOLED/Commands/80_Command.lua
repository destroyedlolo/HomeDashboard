
function Command(topic, msg)
	local cmd = topic:match(".*/(.*)")
	local func = SelSharedRef.Find( cmd )
	if func then
		SelSharedVar.Set("cmd_"..cmd, msg)	-- keep argument for command needing it
		Selene.PushTaskByRef( func )
	end
	return true
end

SelLog.Log('C', 'Command topic : "HomeDashBoard/'.. MQTT_ClientID .. '/#"')
SelLog.Log('C', '"HomeDashBoard/'.. MQTT_ClientID .. '/Help" for supported topics list')
table.insert( Topics, 
	{ topic = 'HomeDashBoard/'.. MQTT_ClientID ..'/#', func=Command }
)


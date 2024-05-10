-- Display commands descriptions

-- Commands have to had their descriptions here
cmd_desc = { Help = "List known commands" }

-- function triggered
function cmd_help()
	SelLog.Log('I', 'Command topic : "HomeDashBoard/'.. MQTT_ClientID .. '/#"')
	SelLog.Log('I', 'List of supported commands')
	for cmd, desc in pairs(cmd_desc) do
		SelLog.Log('I', '\t"' .. cmd ..'" : '.. desc)
	end
end

-- register the function to let threaded func to add it in the todo list
local ref = Selene.RegisterFunction( cmd_help )
SelSharedRef.Register( ref, "Help" )

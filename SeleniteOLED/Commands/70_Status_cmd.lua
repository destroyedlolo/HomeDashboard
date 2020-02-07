-- Display current configuration

cmd_desc.Status = "Display current configuration"

function cmd_status()
	SelLog.log('Current configuration')
	SelLog.log('Switch timer : ' .. switchtimer:Get())
end

local ref = SelShared.RegisterFunction( cmd_status )
SelShared.RegisterRef( ref, "Status" )

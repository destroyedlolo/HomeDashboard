-- Display current configuration

cmd_desc.Status = "Display current configuration"

function cmd_status()
	SelLog.log('Current configuration')
	SelLog.log('Switch timer : ' .. switchtimer:Get())
	SelLog.log('\tconsign : ' .. switchtimerconsign)
	SelLog.log('Screen timeout : ' .. screenWDtimer:Get())
	SelLog.log('\tconsign : ' .. screenWDconsign)
end

local ref = SelShared.RegisterFunction( cmd_status )
SelShared.RegisterRef( ref, "Status" )

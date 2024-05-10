-- Display current configuration

cmd_desc.Status = "Display current configuration"

function cmd_status()
	SelLog.Log('Current configuration')
	SelLog.Log('Switch timer : ' .. switchtimer:Get())
	SelLog.Log('\tconsign : ' .. switchtimerconsign)
	SelLog.Log('Screen timeout : ' .. screenWDtimer:Get())
	SelLog.Log('\tconsign : ' .. screenWDconsign)
end

local ref = Selene.RegisterFunction( cmd_status )
SelSharedRef.Register( ref, "Status" )

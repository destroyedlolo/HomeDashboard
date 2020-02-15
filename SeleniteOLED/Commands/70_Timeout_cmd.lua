-- Change screen timeout

cmd_desc.Timeout = "Change screen timeout consign (0 to disable)"

function cmd_timeout()
	screenWDconsign = tonumber(SelShared.Get('cmd_Timeout'))
	SelLog.log("Timeout consign set to ".. screenWDconsign .." s")
	screenWDtimer:Set { when=screenWDconsign }
	if screenWDtimer:Get() ~= 0 and screenWDtimer:Get() > screenWDconsign then
		screenWDtimer:Reset()
	end
--	SelShared.dump()
end

local ref = SelShared.RegisterFunction( cmd_timeout )
SelShared.RegisterRef( ref, "Timeout" )

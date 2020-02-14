-- Change screen timeout

cmd_desc.Timeout = "Change screen timeout consign (0 to disable)"

function cmd_timeout()
	screenWDconsign = tonumber(SelShared.Get('cmd_Timeout'))
	SelLog.log("Switch timer consign set to ".. screenWDconsign .." s")
	if screenWDtimer:Get() ~= 0 and screenWDtimer:Get() > screenWDconsign then
		screenWDtimer:Set { when=screenWDconsign }
		enableWSwitchTimer()	-- set new consign
		screenWDtimer:Reset()
	end
--	SelShared.dump()
end

local ref = SelShared.RegisterFunction( cmd_timeout )
SelShared.RegisterRef( ref, "Timeout" )

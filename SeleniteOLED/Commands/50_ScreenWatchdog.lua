-- Watchdog timer to turn the screen
function screentimeout()
	off_cmd()
	SelLog.log("Inactivity timeout")
end

screenWDconsign = 60 -- consign for windows switching
screenWDtimer,err = SelTimer.Create { when=screenWDconsign, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), task=screentimeout, once=true}
if err then
	print(err)
	return
end

cmd_desc.Wakeup = "Wake up screen and reset watchdog"

function resetWD()
	if screenWDtimer:Get() == 0 then	-- wakeup the screen
		on_cmd()
	end
	screenWDtimer:Reset()
end

local ref = SelShared.RegisterFunction( resetWD )
SelShared.RegisterRef( ref, "Wakeup" )


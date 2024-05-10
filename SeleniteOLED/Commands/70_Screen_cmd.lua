-- Enable and disable the display

cmd_desc.On = "Turn screen on (WD untouched)"
cmd_desc.Off = "Turn screen off (WD untouched)"

-- Caution, these function are used by the watchdog as well
function on_cmd()
	enableWSwitchTimer()
	SelOLED.OnOff(true)
	SelLog.Log("Screen Enabled")
end

function off_cmd()
	disableWSwitchTimer()
	SelOLED.OnOff(false)
	SelLog.Log("Screen Disabled")
end

local ref = Selene.RegisterFunction( on_cmd )
SelSharedRef.Register( ref, "On" )
ref = Selene.RegisterFunction( off_cmd )
SelSharedRef.Register( ref, "Off" )

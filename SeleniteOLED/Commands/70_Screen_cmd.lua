-- Enable and disable the display

cmd_desc.On = "Turn screen on"
cmd_desc.Off = "Turn screen off"

function on_cmd()
	enableWSwitchTimer()
	SelOLED.OnOff(true)
	SelLog.log("Screen Enabled")
end

function off_cmd()
	disableWSwitchTimer()
	SelOLED.OnOff(false)
	SelLog.log("Screen Disabled")
end

local ref = SelShared.RegisterFunction( on_cmd )
SelShared.RegisterRef( ref, "On" )
ref = SelShared.RegisterFunction( off_cmd )
SelShared.RegisterRef( ref, "Off" )

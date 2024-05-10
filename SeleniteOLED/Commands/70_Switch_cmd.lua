-- Change screen timeout

cmd_desc.Switch = "Change page switch consign"

function cmd_switch()
	local t = tonumber(SelSharedVar.Get('cmd_Switch'))
	if t ~= 0 then
		switchtimerconsign = t
		SelLog.Log("Switch timer consign set to ".. switchtimerconsign .." s")
		if screenWDtimer:Get() ~= 0 then
			enableWSwitchTimer()	-- set new consign
			switchtimer:Reset()
		end
	end
--	SelShared.dump()
end

local ref = Selene.RegisterFunction( cmd_switch )
SelSharedRef.Register( ref, "Switch" )

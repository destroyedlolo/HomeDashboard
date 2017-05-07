-- Manage key events (hight level)

-- Low level events handling and potential translation is done in
-- 80_HardwareEvents and is specific to hardware.

-- Actions table

local keysactions_default = {
-- type / key_name / value
	['KEY/VOLUMEDOWN/1'] = function () prevWindow( true ) end,
	['KEY/VOLUMEUP/1'] = function () nextWindow( true ) end,
	['KEY/POWER/1'] = function () SaveCollection() end,
	['KEY/SEARCH/1'] = function () ConfigMenu() end,
	['KEY/EJECTCD/1'] = function () quitHDB() end,
}

-- Actions

keysactions =  keysactions_default	-- Active keys actions table

function handleevent( t, tp, c, v )	-- (public has the function shall be called from elsewhere)
	local f = keysactions[ SelEvent.TypeName(tp) ..'/'.. SelEvent.KeyName(c) ..'/'.. v ]
	if f then
		f()
	else
		if v ~= 0 then -- Ignore key release when reporting unknown action
			Notification.Log( SelEvent.TypeName(tp) ..'/'.. SelEvent.KeyName(c) ..'/'.. v .. " : Action inconnue" )
			SelLog.log("*I* " .. SelEvent.TypeName(tp) ..'/'.. SelEvent.KeyName(c) ..'/'.. v .. " : Action inconnue" )
		end
	end
end


-- Manage key events

-- Handle keys
local evt

local function handlekeys()
	local t, tp, c, v = evt:read()

	if SelEvent.TypeName(tp) == 'KEY' and v == 1 then
		if SelEvent.KeyName(c) == 'VOLUMEDOWN' then
			prevWindow( true )
		elseif SelEvent.KeyName(c) == 'VOLUMEUP' then
			nextWindow( true )
		elseif SelEvent.KeyName(c) == 'SEARCH' then
			Notification.Log('Not implemented ... yet')
		end
	end
end

evt = SelEvent.create('/dev/input/event1', handlekeys)

table.insert( additionnalevents, evt )

-- Manage key events

-- Handle keys
local evt

function handleevent( tp, c, v )
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

local function handlekeys()
	local t, tp, c, v = evt:read()

	handleevent( tp, c, v )
end

evt = SelEvent.create('/dev/input/event1', handlekeys)

table.insert( additionnalevents, evt )

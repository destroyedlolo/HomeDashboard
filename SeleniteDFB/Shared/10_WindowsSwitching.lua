-- Manage windows stack

winlist = {}		-- Collection of windows to be slided

-- Windows cycling
local wcnt = 0, err
function nextWindow( force )
	if #winlist ~= 0 then
		wcnt = (wcnt + 1) % #winlist
		winlist[ (wcnt % #winlist)+1 ]:RaiseToTop()
	end

	if force then
		Notification.Log('>> ' .. wcnt)
		switchtimer:Reset()
	end
end

function prevWindow( force)
	if #winlist ~= 0 then
		wcnt = wcnt - 1	
		if wcnt < 0 then
			wcnt = #winlist - 1
		end
		winlist[ (wcnt % #winlist)+1 ]:RaiseToTop()
	end

	if force then
		Notification.Log('<< ' .. wcnt)
		switchtimer:Reset()
	end
end

switchtimer,err = SelTimer.create { when=10, interval=10, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), task=nextWindow}
if err then
	print(err)
	return
end

-- Handle keys
local evt

local function handlekeys()
	local t, tp, c, v = evt:read()

	if SelEvent.TypeName(tp) == 'KEY' and v == 1 then
		if SelEvent.KeyName(c) == 'VOLUMEDOWN' then
		elseif SelEvent.KeyName(c) == 'VOLUMEUP' then
			nextWindow(force)
		elseif SelEvent.KeyName(c) == 'SEARCH' then
			Notification.Log('Not implemented ... yet')
		end
	end
end

evt = SelEvent.create('/dev/input/event1', handlekeys)

table.insert( additionnalevents, evt )

-- Manage windows stack

winlist = {}		-- Collection of windows to be slided

-- Windows cycling
local wcnt = 0, err
function switchwindows()
	if #winlist ~= 0 then
		wcnt = (wcnt + 1) % #winlist
		winlist[ (wcnt % #winlist)+1 ]:RaiseToTop()
	end
end

switchtimer,err = SelTimer.create { when=10, interval=10, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), task=switchwindows}
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
			wcnt = wcnt - 1	
			if wcnt < 0 then
				wcnt = #winlist - 1
			end
			Notification.Log('<< ' .. wcnt)
			winlist[ (wcnt % #winlist)+1 ]:RaiseToTop()
			switchtimer:Reset()
		elseif SelEvent.KeyName(c) == 'VOLUMEUP' then
			Notification.Log('>> ' .. wcnt)
			switchwindows()
			switchtimer:Reset()
		elseif SelEvent.KeyName(c) == 'SEARCH' then
			Notification.Log('Not implemented ... yet')
		end
	end
end

evt = SelEvent.create('/dev/input/event1', handlekeys)

table.insert( additionnalevents, evt )

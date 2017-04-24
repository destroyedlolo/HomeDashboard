-- Manage windows stack

winlist = {}		-- Collection of windows to be slided

-- Windows cycling
local wcnt = 0, err
function switchwindows()
	if #winlist ~= 0 then
		winlist[ (wcnt % #winlist)+1 ]:RaiseToTop()
		wcnt = wcnt + 1
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
print('down')
		elseif SelEvent.KeyName(c) == 'VOLUMEUP' then
print('up')
		elseif SelEvent.KeyName(c) == 'SEARCH' then
print('search')
		end
	end
end

evt = SelEvent.create('/dev/input/event1', handlekeys)

table.insert( additionnalevents, evt )

-- Manage windows stack

winlist = {}		-- Collection of windows to be slided
wcnt = 0			-- Current window

-- Windows cycling
local err
function nextWindow( force )
	if #winlist ~= 0 then
		wcnt = (wcnt + 1) % #winlist
		winlist[ (wcnt % #winlist)+1 ].display()
	end

	if force then
		switchtimer:Reset()
	end
end

function prevWindow( force )
	if #winlist ~= 0 then
		wcnt = wcnt - 1	
		if wcnt < 0 then
			wcnt = #winlist - 1
		end
		winlist[ (wcnt % #winlist)+1 ].display()
	end

	if force then
		switchtimer:Reset()
	end
end

switchtimerconsign = 3 -- consign for windows switching
switchtimer,err = SelTimer.Create { when=3, interval=3, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), task=nextWindow}
if err then
	print(err)
	return
end

function disableWSwitchTimer()
	switchtimer:Set { when=0, interval=0 }
end

function enableWSwitchTimer()
	switchtimer:Set { when=switchtimerconsign, interval=switchtimerconsign }
end

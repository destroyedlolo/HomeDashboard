-- Manage windows stack

winlist = {}		-- Collection of windows to be slided

-- Windows cycling
local wcnt = 0, err

function nextWindow( force )
	winlist[ (wcnt % #winlist)+1 ].Visibility(false)
	if #winlist ~= 0 then
		wcnt = (wcnt + 1) % #winlist
	end
	winlist[ (wcnt % #winlist)+1 ].Visibility(true)

	if force then
		switchtimer:Reset()
	end
end

function prevWindow( force)
	winlist[ (wcnt % #winlist)+1 ].Visibility(false)
	if #winlist ~= 0 then
		wcnt = wcnt - 1	
		if wcnt < 0 then
			wcnt = #winlist - 1
		end
		winlist[ (wcnt % #winlist)+1 ]:RaiseToTop()
	end
	winlist[ (wcnt % #winlist)+1 ].Visibility(true)

	if force then
		switchtimer:Reset()
	end
end

switchtimer,err = SelTimer.Create { when=10, interval=10, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), task=nextWindow}
if err then
	print(err)
	return
end


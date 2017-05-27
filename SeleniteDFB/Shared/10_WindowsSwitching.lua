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
		switchtimer:Reset()
	end
end

switchtimer,err = SelTimer.create { when=10, interval=10, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), task=nextWindow}
if err then
	print(err)
	return
end



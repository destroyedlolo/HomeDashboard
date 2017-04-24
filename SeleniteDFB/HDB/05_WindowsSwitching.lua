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

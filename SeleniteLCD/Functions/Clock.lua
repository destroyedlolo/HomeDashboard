local function setChar( num, val, min)
-- Redefine a char as per value
-- num : number of the char
-- val : value 1-12
-- min : if true, add ':' behind
	local dt = {
		{
			"    ",
			"  x ",
			" x x",
			" x x",
			" x x",
			" x x",
			"  x ",
			"     "
		}, {
			"    ",
			"  x ",
			" xx ",
			"  x ",
			"  x ",
			"  x ",
			" xxx",
			"     "
		}, {
			"    ",
			" xxx",
			"   x",
			" xxx",
			" x  ",
			" x  ",
			" xxx",
			"     "
		}, {
			"    ",
			" xxx",
			"   x",
			"  xx",
			"   x",
			"   x",
			" xxx",
			"     "
		}, {
			"    ",
			" x x",
			" x x",
			"  xx",
			"   x",
			"   x",
			"   x",
			"     "
		}, {
			"    ",
			" xxx",
			" x  ",
			" xxx",
			"   x",
			"   x",
			" xxx",
			"    "
		}, {
			"    ",
			" xx ",
			" x  ",
			" xxx",
			" x x",
			" x x",
			" xxx",
			"    "
		}, {
			"    ",
			" xxx",
			"   x",
			"   x",
			"   x",
			"   x",
			"   x",
			"    "
		}, {
			"    ",
			" xxx",
			" x x",
			" xxx",
			" x x",
			" x x",
			" xxx",
			"    "
		}, {
			"    ",
			" xxx",
			" x x",
			" xxx",
			"   x",
			"   x",
			" xxx",
			"     "
		}, {
			"     ",
			"x  x ",
			"x x x",
			"x x x",
			"x x x",
			"x x x",
			"x  x ",
			"     "
		}, {
			"     ",
			" x  x",
			"xx xx",
			" x  x",
			" x  x",
			" x  x",
			" x  x",
			"     "
		}, {
			"     ",
			"x xxx",
			"x   x",
			"x xxx",
			"x x  ",
			"x x  ",
			"x xxx",
			"     "
		}
	}

	local t = dt[val]
	if min then
		for i=1,8 do
			if (i%3) == 0 then
				t[i] = 'X' .. t[i]
			else
				t[i] = ' ' .. t[i]
			end
		end
	end

	lcd:SetChar(num, t)
end


function displayTime()
	local t = os.date('*t')

	clockTimer:Set { when=60-t.sec }	-- Ready for next run

	if t.hour ~= 12 then
		t.hour = t.hour%12
	end

	setChar(0, t.hour +1, false)
	setChar(1, math.floor(t.min/10) +1, true)
	setChar(2, t.min%10 +1, false)

	lcd:SetCursor(13,1)
	lcd:WriteString( string.char(0x08)..string.char(0x09)..string.char(0x0a))
end

clockTimer = SelTimer.Create { when=60, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), task=displayTime }

displayTime()

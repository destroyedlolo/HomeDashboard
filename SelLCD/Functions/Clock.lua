local function setChar( num, val, min)
-- Redefine a char as per value
-- num : number of the char
-- val : value 1-12
-- min : if true, add ':' behind
	local dt = {
		{
			"     ",
			"   x ",
			"  x x",
			"  x x",
			"  x x",
			"  x x",
			"   x ",
			"     "
		}, {
			"     ",
			"   x ",
			"  xx ",
			"   x ",
			"   x ",
			"   x ",
			"  xxx",
			"     "
		}, {
			"     ",
			"  xxx",
			"    x",
			"  xxx",
			"  x  ",
			"  x  ",
			"  xxx",
			"     "
		}, {
			"     ",
			"  xxx",
			"    x",
			"   xx",
			"    x",
			"    x",
			"  xxx",
			"     "
		}, {
			"     ",
			"  x x",
			"  x x",
			"   xx",
			"    x",
			"    x",
			"    x",
			"     "
		}, {
			"     ",
			"  xxx",
			"  x  ",
			"  xxx",
			"    x",
			"    x",
			"  xxx",
			"     "
		}, {
			"     ",
			"  xx ",
			"  x  ",
			"  xxx",
			"  x x",
			"  x x",
			"  xxx",
			"     "
		}, {
			"     ",
			"  xxx",
			"    x",
			"    x",
			"    x",
			"    x",
			"    x",
			"     "
		}, {
			"     ",
			"  xxx",
			"  x x",
			"  xxx",
			"  x x",
			"  x x",
			"  xxx",
			"     "
		}, {
			"     ",
			"  xxx",
			"  x x",
			"  xxx",
			"    x",
			"    x",
			"  xxx",
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

--[[
print(dt[val])
for _,v in pairs(dt[val])
do
	print(v)
end
--]]
	lcd:SetChar(num, dt[val])
end

function displayTime()
	local t = os.date('*t')
	print(t.hour%12, math.floor(t.min/10), t.min%10)

	setChar(0, t.hour%12 +1, false)
	setChar(1, math.floor(t.min/10) +1, true)
	setChar(2, t.min%10 +1, false)

	lcd:SetCursor(13,1)
	lcd:WriteString( string.char(0x08)..string.char(0x09)..string.char(0x0a))
end

displayTime()

-- Define custom characters
-- char 0-2 are already used by the clock

lcd:SetChar(3, {
	"     ",
	"  XXx",
	" xxx ",
	"xxx  ",
	"  xx ",
	" xx  ",
	"x    ",
	"     "
})

lcd:SetChar(4, {
	"     ",
	" x x ",
	"xxxxx",
	"xxxxx",
	"xxxxx",
	" xxx ",
	"  x  ",
	"  x  "
})

lcd:SetChar(5, {
	" xXX ",
	"x   X",
	"XXX  ",
	"X    ",
	"XXX  ",
	"x   X",
	" xXx ",
	"     "
})

lcd:SetChar(6, {
	"x   x",
	"x  x ",
	"x x  ",
	"xx  x",
	"x  xx",
	"  x x",
	" xxxx",
	"x   x"
})
--[[
lcd:SetCursor(0,1)
lcd:WriteString("New : ")
for j = 0x08, 0x0f do
	lcd:WriteString( string.char(j) )
end

io.stdin:read'*l'       -- wait for enter
--]]

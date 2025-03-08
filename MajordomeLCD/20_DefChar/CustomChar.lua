-->> RunAtStartup
-->> need_renderer=LCD

-- Define custom characters
-- char 0-2 are already used by the clock

LCD:SetChar(3, {
	"     ",
	"  XXx",
	" xxx ",
	"xxx  ",
	"  xx ",
	" xx  ",
	"x    ",
	"     "
})

LCD:SetChar(4, {
	"     ",
	" x x ",
	"xxxxx",
	"xxxxx",
	"xxxxx",
	" xxx ",
	"  x  ",
	"  x  "
})

LCD:SetChar(5, {
	" xXX ",
	"x   X",
	"XXX  ",
	"X    ",
	"XXX  ",
	"x   X",
	" xXx ",
	"     "
})

LCD:SetChar(6, {
	"x   x",
	"x  x ",
	"x x  ",
	"xx  x",
	"x  xx",
	"  x x",
	" xxxx",
	"x   x"
})


-- Font to use
-- format { "facename", size }

local finternal = SelDCFont.createInternal("")
local fontTT,err,msg = SelDCFont.createFreeType("/usr/share/fonts/liberation-fonts/LiberationSerif-BoldItalic.ttf")
if not fontTT then
        print("*E*", err,msg)
        os.exit()
end

fonts={
	title = { font=finternal, size=20 },
	title1 = { font=fontTT, size=13 },
	digit = { font=finternal, size=17 },
	mdigit = { font=finternal, size=13 },
	sdigit = { font=finternal, size=10 },
	xstxt = { font=finternal, size=7 },
	stxt = { font=finternal, size=8 },
	mtxt = { font=finternal, size=10 },
	menu = { font=finternal, size=15 }
}

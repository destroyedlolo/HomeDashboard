-- Font to use
-- format { "facename", size }

local finternal = SelDCFont.createInternal("")
local fontTT,err,msg = SelDCFont.createFreeType("/usr/share/fonts/liberation-fonts/LiberationSerif-BoldItalic.ttf")
if not fontTT then
        print("*E*", err,msg)
        os.exit()
end

fonts={
	title = { font=finternal, size=36 },
	title1 = { font=fontTT, size=24 },
	digit = { font=finternal, size=42 },
	mdigit = { font=finternal, size=31 },
	sdigit = { font=finternal, size=18 },
	xstxt = { font=finternal, size=9.6 },
	stxt = { font=finternal, size=11 },
	mtxt = { font=finternal, size=12 },
	menu = { font=finternal, size=29 }
}

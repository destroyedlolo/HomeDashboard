-- Font to use
-- format { "facename", size }

local finternal = SelDCFont.createInternal("")
local fontTT,err,msg = SelDCFont.createFreeType("/usr/share/fonts/liberation-fonts/LiberationSerif-BoldItalic.ttf")
if not fontTT then
        print("*E*", err,msg)
        os.exit()
end

local fontSeg
fontSeg,err,msg = SelDCFont.createFreeType(SELENE_SCRIPT_DIR .. "/Ressources/Seven Segment.ttf")
if not fontSeg then
        print("*E*", err,msg)
        os.exit()
end

fonts={
	title = { font=finternal, size=36 },
	title1 = { font=fontTT, size=24 },
	digit = { font=finternal, size=42 },
	mdigit = { font=finternal, size=31 },
	smdigit = { font=finternal, size=25 },
	sdigit = { font=finternal, size=22 },
	xsdigit = { font=finternal, size=17 },
	seg = { font=fontSeg, size=42 },
	mseg = { font=fontSeg, size=31 },
	sseg = { font=fontSeg, size=18 },
	xstxt = { font=finternal, size=9.6 },
	stxt = { font=finternal, size=11 },
	mtxt = { font=finternal, size=12 },
	menu = { font=finternal, size=29 }
}

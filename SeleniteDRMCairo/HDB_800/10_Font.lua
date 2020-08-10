-- Font to use
-- format { "facename", size }

local finternal = SelDCFont.createInternal("")
local fontTT,err,msg = SelDCFont.createFreeType("/usr/share/fonts/liberation-fonts/LiberationSerif-BoldItalic.ttf")
if not fontTT then
        print("*E*", err,msg)
        os.exit()
end

fonts={
	title = { font=finternal, size=30 },
	title1 = { font=fontTT, size=20 },
	digit = { font=finternal, size=35 },
	mdigit = { font=finternal, size=26 },
	sdigit = { font=finternal, size=15 },
	xstxt = { font=finternal, size=8 },
	stxt = { font=finternal, size=9 },
	mtxt = { font=finternal, size=10 },
	menu = { font=finternal, size=24 }
}

--[[
ftitle = SelFont.create("/usr/local/share/fonts/CarroisGothic-Regular.ttf", { height=30} )
ftitle1 = SelFont.create("/usr/local/share/fonts/Capsuula.ttf", { height=20} )
fdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=35} )
fmdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=26} )
fsdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=20} )
fstxt = SelFont.create("/usr/local/share/fonts/firasanscompressed-light.otf", { height=8} )
fmtxt = SelFont.create("/usr/local/share/fonts/firasanscompressed-light.otf", { height=10} )
fmenu = SelFont.create("/usr/local/share/fonts/firasanscompressed-light.otf", { height=24} )
--]]

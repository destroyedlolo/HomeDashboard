-- Design of the display

local HSGRPH = 30	-- Height of small graphs
local VBAR1 = 160	-- position of the first vertical bar
local VBAR2 = 500	-- position of the first vertical bar
BARZOOM = 5	-- Magnify bar

-- compatibility with newer Lua
local unpack = unpack or table.unpack

-- Font used
ftitle = SelFont.create("/usr/local/share/fonts/CarroisGothic-Regular.ttf", { height=30} )
ftitle1 = SelFont.create("/usr/local/share/fonts/Capsuula.ttf", { height=20} )
fdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=35} )
fmdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=30} )
fsdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=20} )

-----
-- Electricity
-----

-- title
psrf:SetFont( ftitle )
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine( VBAR1, 0, VBAR1, psrf:GetHeight() )
psrf:DrawString("Electricité :", 5,0)
local offy = 5+ftitle:GetHeight()

psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Tension EDF :", 5, offy )
offy = offy + ftitle1:GetHeight()
srf_tension = psrf:SubSurface( 10, offy, VBAR1-20, fmdigit:GetHeight() )
srf_tension:SetFont( fmdigit )
srf_tension:SetColor( unpack(COL_DIGIT) )
offy = offy + fmdigit:GetHeight()

psrf:DrawString("Consommation :", 5, offy)
offy = offy + ftitle1:GetHeight()
srf_consommation = psrf:SubSurface( 10, offy, VBAR1-20, fdigit:GetHeight() )
srf_consommation:SetFont( fdigit )
srf_consommation:SetColor( unpack(COL_DIGIT) )
offy = offy + fdigit:GetHeight()
local xoffmaxc = VBAR1 - (5 + fsdigit:StringWidth("12345"))
srf_maxconso = psrf:SubSurface( xoffmaxc, offy, fsdigit:StringWidth("12345"), HSGRPH);
srf_maxconso:SetFont( fsdigit )
srf_maxconso:SetColor( unpack(COL_DIGIT) )
srf_consogfx = psrf:SubSurface( 5, offy, xoffmaxc -5, HSGRPH)
srf_consogfx:SetColor( unpack(COL_RED) )
offy = offy + HSGRPH

psrf:DrawString("Production :", 5, offy)
offy = offy + ftitle1:GetHeight()
srf_production = psrf:SubSurface( 10, offy, VBAR1-20, fdigit:GetHeight() )
srf_production:SetFont( fdigit )
srf_production:SetColor( unpack(COL_DIGIT) )
offy = offy + fdigit:GetHeight()

-----
-- Tablet
-----
local btab = 25 + ftitle:GetHeight() + 3*ftitle1:GetHeight() + 3*fdigit:GetHeight() + HSGRPH

psrf:SetFont( ftitle )
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine(0, btab, VBAR1, btab )
psrf:DrawString("Tablette :", 5, btab + 5)

srf_tabpwr = psrf:SubSurface( 10, btab + ftitle:GetHeight(), VBAR1-20, fdigit:GetHeight() )
srf_tabpwr:SetColor( unpack(COL_DIGIT) )

xoffmaxc = VBAR1 - (5 + fsdigit:StringWidth("10.88"))
srf_maxtpwr = psrf:SubSurface( xoffmaxc, btab + ftitle:GetHeight() + fdigit:GetHeight(), fsdigit:StringWidth("10.88"), HSGRPH);
srf_maxtpwr:SetColor( unpack(COL_DIGIT) )
srf_tpwrgfx =  psrf:SubSurface( 5, btab + ftitle:GetHeight() + fdigit:GetHeight(), xoffmaxc - 5, HSGRPH);
srf_tpwrgfx:SetColor( unpack(COL_RED) )

psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("PMU", 5, btab + ftitle:GetHeight() + fdigit:GetHeight() + HSGRPH)
psrf:DrawString("Batterie", 5 + VBAR1 / 2, btab + ftitle:GetHeight() + fdigit:GetHeight() + HSGRPH)

srf_ttpmu = psrf:SubSurface( 5, btab + ftitle:GetHeight() + fdigit:GetHeight() + HSGRPH + ftitle1:GetHeight(), VBAR1 / 2 - 10, ftitle1:GetHeight() )
srf_ttpmu:SetColor( unpack(COL_DIGIT) )
srf_ttbat = psrf:SubSurface( 5 + VBAR1 / 2, btab + ftitle:GetHeight() + fdigit:GetHeight() + HSGRPH + ftitle1:GetHeight(), VBAR1 / 2 - 10, ftitle1:GetHeight() )
srf_ttbat:SetColor( unpack(COL_DIGIT) )

----
-- Onduleur
----
psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Onduleur :", VBAR1 + 5, 5 )
srf_consoUPS = psrf:SubSurface( VBAR1 + 5 + ftitle1:StringWidth("Onduleur : "), 5, ftitle1:StringWidth("200.6 W"), ftitle1:GetHeight() )
srf_consoUPS:SetColor( unpack(COL_DIGIT) )

local tx,ty = srf_consoUPS:GetPosition()
local tw,th = srf_consoUPS:GetSize()
goffy = ty + th + 2	-- bar's offset
bar_ups = { x=VBAR1+6, y=goffy+1, w=tx+tw-VBAR1-1, h=8 }
psrf:SetColor( unpack( COL_WHITE ) )
psrf:DrawRectangle( bar_ups.x-1, bar_ups.y-1, bar_ups.w+2, bar_ups.h+2 )

xcursor = tx+tw+15	-- x cursor
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine( xcursor, 0, xcursor, bar_ups.y + bar_ups.h + 4 )

----
-- Internet
----

xcursor = xcursor + 15
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Internet :", xcursor, 5 )
srf_Internet = psrf:SubSurface( xcursor + ftitle1:StringWidth("Internet : "), 5, ftitle1:StringWidth("8888 kb / 2000 kb"), ftitle1:GetHeight() )
srf_Internet:SetColor( unpack(COL_DIGIT) )
tx, ty = srf_Internet:GetPosition()
tw, th = srf_Internet:GetSize()
tw = tx + tw - xcursor	-- width for bars
bar_Idn = { x=xcursor+1, y=goffy+1, w=tw/2-2, h=8 }
bar_Iup = { x=xcursor + tw/2 +4, y=goffy+1, w=tw/2-2, h=8 }
psrf:SetColor( unpack( COL_WHITE ) )
psrf:DrawRectangle( bar_Idn.x-1, bar_Idn.y-1, bar_Idn.w+2, bar_Idn.h+2 )
psrf:DrawRectangle( bar_Iup.x-1, bar_Iup.y-1, bar_Iup.w+2, bar_Iup.h+2 )

psrf:SetColor( unpack(COL_BORDER) )
goffy = bar_ups.y + bar_ups.h + 4
psrf:DrawLine(VBAR1, goffy, psrf:GetWidth(), goffy )


----
-- Temperature
----

goffy = goffy
psrf:SetFont( ftitle )
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawString("Températures :", VBAR1+5, goffy )

goffy = goffy + ftitle:GetHeight()
psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Comble :", VBAR1+5, goffy )
psrf:DrawString("Grenier nord :", VBAR1+170, goffy )
goffy = goffy + ftitle1:GetHeight()
	-- calculate against fdigit and not fsdigit to aligned with other temperature
srf_TComble = psrf:SubSurface( VBAR1+5, goffy, 30 + fdigit:StringWidth("-888.8°C"), fsdigit:GetHeight() )
srf_TComble:SetColor( unpack(COL_DIGIT) )
srf_TGrN = psrf:SubSurface( VBAR1+170, goffy, 30 + fdigit:StringWidth("-888.8°C"), fsdigit:GetHeight() )
srf_TGrN:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fsdigit:GetHeight()

psrf:DrawString("Chambre Océane :", VBAR1+5, goffy )
psrf:DrawString("Chambre Joris :", VBAR1+170, goffy )
goffy = goffy + ftitle1:GetHeight()
srf_TChO = psrf:SubSurface( VBAR1+5, goffy, 30 + fdigit:StringWidth("-888.8°C"), fdigit:GetHeight() )
srf_TChO:SetColor( unpack(COL_DIGIT) )
srf_TChJ = psrf:SubSurface( VBAR1+170, goffy, 30 + fdigit:StringWidth("-888.8°C"), fdigit:GetHeight() )
srf_TChJ:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fdigit:GetHeight()

psrf:DrawString("Salon :", VBAR1+5, goffy )
psrf:DrawString("Bureau :", VBAR1+170, goffy )
goffy = goffy + ftitle1:GetHeight()
srf_TSalon = psrf:SubSurface( VBAR1+5, goffy, 30 + fdigit:StringWidth("-888.8°C"), fdigit:GetHeight() )
srf_TSalon:SetColor( unpack(COL_DIGIT) )
srf_TBureau = psrf:SubSurface( VBAR1+170, goffy, 30 + fdigit:StringWidth("-888.8°C"), fdigit:GetHeight() )
srf_TBureau:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fdigit:GetHeight()

psrf:DrawString("Dehors :", VBAR1+5, goffy )
psrf:DrawString("Cave :", VBAR1+170, goffy )
goffy = goffy + ftitle1:GetHeight()
srf_TDehors = psrf:SubSurface( VBAR1+5, goffy, 30 + fdigit:StringWidth("-888.8°C"), fdigit:GetHeight() )
srf_TDehors:SetColor( unpack(COL_DIGIT) )
srf_TCave = psrf:SubSurface( VBAR1+170, goffy, 30 + fdigit:StringWidth("-888.8°C"), fdigit:GetHeight() )
srf_TCave:SetColor( unpack(COL_DIGIT) )
goffy = goffy + fdigit:GetHeight()

-----
-- Short term meteo
-----

goffy3h = bar_ups.y + bar_ups.h + 4
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine( VBAR2, goffy3h, VBAR2, goffy )
VBAR2 = VBAR2 + 5
psrf:SetFont( ftitle )
psrf:DrawString("Météo du jour", VBAR2, goffy3h + 1)

goffy3h = goffy3h + ftitle1:GetHeight() + 10

srf_Meteo3H = {			-- Icon
	psrf:SubSurface( VBAR2, goffy3h, 115, 82 ),
	psrf:SubSurface( VBAR2 + 10, goffy3h + 90 + fsdigit:GetHeight(), 78, 56 ),
	psrf:SubSurface( VBAR2 + 120, goffy3h + 90 + fsdigit:GetHeight(), 78, 56 ),
	psrf:SubSurface( VBAR2 + 220, goffy3h + 90 + fsdigit:GetHeight(), 78, 56 )
}

srf_MeteoTime3H = { 	-- Time
	psrf:SubSurface( psrf:GetWidth() - fsdigit:StringWidth("88:88"), goffy3h+5, fsdigit:StringWidth("88:88"), fsdigit:GetHeight() ),
	psrf:SubSurface( VBAR2, goffy3h + 90, 92, fsdigit:GetHeight()), 
	psrf:SubSurface( VBAR2 + 110, goffy3h + 90, 92, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR2 + 210, goffy3h + 90, 92, fsdigit:GetHeight())
}

srf_MeteoTemp3H = {		-- Temperature
	psrf:SubSurface( VBAR2 + 115, goffy3h+10, fdigit:StringWidth("-88:8°C"), fdigit:GetHeight() ),
	psrf:SubSurface( VBAR2, goffy3h + 146 + fsdigit:GetHeight(), 80, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR2 + 110, goffy3h + 146 + fsdigit:GetHeight(), 80, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR2 + 210, goffy3h + 146 + fsdigit:GetHeight(), 80, fsdigit:GetHeight())
}

srf_MeteoWind3H = {
	psrf:SubSurface( psrf:GetWidth() - fsdigit:StringWidth("-888.8") - fsdigit:GetHeight(), goffy3h + 5 + fsdigit:GetHeight(), fsdigit:StringWidth("88:88"), fsdigit:GetHeight() ),
	psrf:SubSurface( VBAR2, goffy3h + 146 + 2*fsdigit:GetHeight(), 80 - fsdigit:GetHeight(), fsdigit:GetHeight()),
	psrf:SubSurface( VBAR2 + 110, goffy3h + 146 + 2*fsdigit:GetHeight(), 80 - fsdigit:GetHeight(), fsdigit:GetHeight()),
	psrf:SubSurface( VBAR2 + 210, goffy3h + 146 + 2*fsdigit:GetHeight(), 80 - fsdigit:GetHeight(), fsdigit:GetHeight())
}

srf_MeteoWindd3H = {
	psrf:SubSurface( psrf:GetWidth() - fsdigit:GetHeight(), goffy3h + 5 + fsdigit:GetHeight(), fsdigit:GetHeight(), fsdigit:GetHeight() ),
	psrf:SubSurface( VBAR2 + 80 - fsdigit:GetHeight(), goffy3h + 146 + 2*fsdigit:GetHeight(), fsdigit:GetHeight(), fsdigit:GetHeight() ),
	psrf:SubSurface( VBAR2 + 190 - fsdigit:GetHeight(), goffy3h + 146 + 2*fsdigit:GetHeight(), fsdigit:GetHeight(), fsdigit:GetHeight() ),
	psrf:SubSurface( VBAR2 + 290 - fsdigit:GetHeight(), goffy3h + 146 + 2*fsdigit:GetHeight(), fsdigit:GetHeight(), fsdigit:GetHeight() )
}

for i=1,4 do
	srf_MeteoTime3H[i]:SetColor( unpack(COL_DIGIT) )
	srf_MeteoWind3H[i]:SetColor( unpack(COL_DIGIT) )
end

drawWind( srf_MeteoWindd3H[1], 0 )
drawWind( srf_MeteoWindd3H[2], 90 )

-----
-- Meteo
-----

psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine(VBAR1, goffy, psrf:GetWidth(), goffy )
goffy = goffy + 5

srf_Meteo = { 
	psrf:SubSurface( VBAR1+9, goffy, 92,66),
	psrf:SubSurface( VBAR1+139, goffy, 92,66),
	psrf:SubSurface( VBAR1+269, goffy, 92,66),
	psrf:SubSurface( VBAR1+399, goffy, 92,66),
	psrf:SubSurface( VBAR1+529, goffy, 92,66)
}

goffy = goffy + 66

srf_MeteoDate = {
	psrf:SubSurface( VBAR1+9, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+139, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+269, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+399, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+529, goffy, 86, fsdigit:GetHeight()),
}
for i=1,5 do
	srf_MeteoDate[i]:SetColor( unpack(COL_DIGIT) )
end

goffy = goffy + fsdigit:GetHeight()

srf_MeteoTMax = {
	psrf:SubSurface( VBAR1+9, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+139, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+269, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+399, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+529, goffy, 86, fsdigit:GetHeight()),
}

goffy = goffy + fsdigit:GetHeight()

srf_MeteoTMin = {
	psrf:SubSurface( VBAR1+9, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+139, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+269, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+399, goffy, 86, fsdigit:GetHeight()),
	psrf:SubSurface( VBAR1+529, goffy, 86, fsdigit:GetHeight()),
}



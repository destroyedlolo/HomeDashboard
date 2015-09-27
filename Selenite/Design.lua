-- Design of the display

local HSGRPH = 30	-- Height of small graphs
local VBAR1 = 160	-- position of the first vertical bar

-- compatibility with newer Lua
local unpack = unpack or table.unpack

-- Font used
ftitle = SelFont.create("/usr/local/share/fonts/CarroisGothic-Regular.ttf", { height=30} )
ftitle1 = SelFont.create("/usr/local/share/fonts/Capsuula.ttf", { height=20} )
fdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=35} )
fsdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=20} )

-----
-- Electricity
-----

function upddata( srf, font, data )
	srf:SetFont( font )
	srf:Clear( unpack(COL_BLACK) )
	srf:DrawString( data, srf:GetWidth() - font:StringWidth(data), 0)
end

-- title
psrf:SetFont( ftitle )
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine( VBAR1, 0, VBAR1, psrf:GetHeight() )
psrf:DrawString("Electricité :", 5,0)

-- figures' sub titles
psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Tension EDF :", 5, 5+ftitle:GetHeight() )
psrf:DrawString("Consommation :", 5, 5 + ftitle:GetHeight() + ftitle1:GetHeight() + fdigit:GetHeight())
psrf:DrawString("Production :", 5, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + 2*fdigit:GetHeight() + HSGRPH)

-- figures' subsurfaces
srf_tension = psrf:SubSurface( 10, 5 + ftitle:GetHeight() + ftitle1:GetHeight(), VBAR1-20, fdigit:GetHeight() )
srf_tension:SetColor( unpack(COL_DIGIT) )
srf_consommation = psrf:SubSurface( 10, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + fdigit:GetHeight(), VBAR1-20, fdigit:GetHeight() )
srf_consommation:SetColor( unpack(COL_DIGIT) )
srf_production = psrf:SubSurface( 10, 5 + ftitle:GetHeight() + 3*ftitle1:GetHeight() + 2*fdigit:GetHeight() + HSGRPH, VBAR1-20, fdigit:GetHeight() )
srf_production:SetColor( unpack(COL_DIGIT) )

local xoffmaxc = VBAR1 - (5 + fsdigit:StringWidth("12345"))
srf_maxconso = psrf:SubSurface( xoffmaxc, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + 2*fdigit:GetHeight(), fsdigit:StringWidth("12345"), HSGRPH);
srf_maxconso:SetColor( unpack(COL_DIGIT) )
srf_consogfx = psrf:SubSurface( 5, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + 2*fdigit:GetHeight(), xoffmaxc -5, HSGRPH)

-----
-- Tablet
-----
local btab = 20 + ftitle:GetHeight() + 3*ftitle1:GetHeight() + 3*fdigit:GetHeight() + HSGRPH

psrf:SetFont( ftitle )
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine(0, btab, VBAR1, btab )
psrf:DrawString("Tablette :", 5, btab + 5)

srf_tabpwr = psrf:SubSurface( 10, btab + ftitle:GetHeight(), VBAR1-20, fdigit:GetHeight() )
srf_tabpwr:SetColor( unpack(COL_DIGIT) )

-- Test

psrf:SetFont( fdigit )
psrf:SetColor( unpack(COL_DIGIT) )

upddata( srf_maxconso, fsdigit, "12345" )
srf_consogfx:Clear(10,10,10,255)



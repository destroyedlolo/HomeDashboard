-- Design of the display

local HSGRPH = 30	-- Height of small graphs
local VBAR1 = 160	-- position of the first vertical bare

-- Font used
ftitle = SelFont.create("/usr/local/share/fonts/CarroisGothic-Regular.ttf", { height=30} )
ftitle1 = SelFont.create("/usr/local/share/fonts/Capsuula.ttf", { height=20} )
fdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=35} )
fsdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=20} )

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
psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Tension EDF :", 5, 5+ftitle:GetHeight() )
psrf:DrawString("Consommation :", 5, 5 + ftitle:GetHeight() + ftitle1:GetHeight() + fdigit:GetHeight())
psrf:DrawString("Production :", 5, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + 2*fdigit:GetHeight() + HSGRPH)

-- figures' subsurfaces
srf_tension = psrf:SubSurface( 10, 5 + ftitle:GetHeight() + ftitle1:GetHeight(), VBAR1-20, fdigit:GetHeight() )
srf_tension:SetColor( unpack(COL_DIGIT) )
srf_production = psrf:SubSurface( 10, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + fdigit:GetHeight(), VBAR1-20, fdigit:GetHeight() )
srf_production:SetColor( unpack(COL_DIGIT) )
srf_consommation = psrf:SubSurface( 10, 5 + ftitle:GetHeight() + 3*ftitle1:GetHeight() + 2*fdigit:GetHeight() + HSGRPH, VBAR1-20, fdigit:GetHeight() )
srf_consommation:SetColor( unpack(COL_DIGIT) )

-- Test
upddata( srf_tension, fdigit, "230 V" )
upddata( srf_production, fdigit, "12345 VA" )
upddata( srf_consommation, fdigit, "12345 VA" )

psrf:SetFont( fdigit )
psrf:SetColor( unpack(COL_DIGIT) )

psrf:SetFont( fsdigit )
psrf:DrawString("12345", 90, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + 2*fdigit:GetHeight())

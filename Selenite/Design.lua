-- Design of the display

-- Font used
ftitle = SelFont.create("/usr/local/share/fonts/CarroisGothic-Regular.ttf", { height=30} )
ftitle1 = SelFont.create("/usr/local/share/fonts/Capsuula.ttf", { height=20} )
fdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=35} )

-- title

psrf:SetFont( ftitle )
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawString("Electricité :", 5,0)
psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Tension EDF :", 5, 5+ftitle:GetHeight() )
psrf:DrawString("Consommation :", 5, 5 + ftitle:GetHeight() + ftitle1:GetHeight() + fdigit:GetHeight())
psrf:DrawString("Production :", 5, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + 2*fdigit:GetHeight())

psrf:SetFont( fdigit )
psrf:SetColor( unpack(COL_DIGIT) )
psrf:DrawString("230 V", 5, 5 + ftitle:GetHeight() + ftitle1:GetHeight())
psrf:DrawString("12345 VA", 5, 5 + ftitle:GetHeight() + 2*ftitle1:GetHeight() + fdigit:GetHeight())
psrf:DrawString("12345 VA", 5, 5 + ftitle:GetHeight() + 3*ftitle1:GetHeight() + 2*fdigit:GetHeight())


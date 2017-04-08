-- Weather forcast
local function meteo()
	local self = {}
	local x,y 

	local window = layer:CreateWindow {
		pos = WINTOP, size = WINSIZE,
		caps=SelWindow.CapsConst('NONE'),
		surface_caps=SelSurface.CapabilityConst('NONE')
	}
	window:SetOpacity(0xff)	-- Make the window visible
	table.insert( winlist, window )
	local srf = window:GetSurface()

	srf:SetColor( COL_TITLE.get() )
	srf:SetFont( ftitle )
	srf:DrawString("Nonglard", 0, 0)

	local currentw = cweather( srf, 0, ftitle:GetHeight() + 20 )
	local w0 = Weather3H(currentw, 'Meteo3H', 'Nonglard', 0)

	srf:SetColor( COL_BORDER.get() )
	y =  currentw.getBellow() + 15
	srf:DrawLine( 20, y, 270, y )
	y = y + 15

	local plus1 = stweather( srf, 0, y )
	local w1 = Weather3H(plus1, 'Meteo3H', 'Nonglard', 1)

	local plus2 = stweather( srf, plus1.getNext() + 5, y )
	local w2 = Weather3H(plus2, 'Meteo3H', 'Nonglard', 2)

	local plus3 = stweather( srf, plus2.getNext() + 5, y )
	local w3 = Weather3H(plus3, 'Meteo3H', 'Nonglard', 3)

	local img,err = SelImage.create(SELENE_SCRIPT_DIR .."/Images/Sunrise.png")
	assert(img)
	img:RenderTo( srf, { 200 , 0, ftitle:GetHeight(), ftitle:GetHeight() } )
	img:destroy()

	srf:SetFont( fmdigit )
	srf:SetColor( COL_TITLE.get() )
	local sunrise = Field( srf, 210 + ftitle:GetHeight(), 0,
		fmdigit, COL_DIGIT, {
			align = ALIGN_CENTER,
			sample_text = '88:88'
		}
	)
	MQTTDisplay( 'SunriseNonlard', "Meteo/Nonglard/sunrise", sunrise )

	x,y = sunrise.get():GetAfter()
	srf:DrawString(" - ", x, y)
	x = x + fmdigit:StringWidth(" - ")
	local sunset= Field( srf, x, 0,
		fmdigit, COL_DIGIT, {
			align = ALIGN_CENTER,
			sample_text = '88:88'
		}
	)
	MQTTDisplay( 'SunsetNonlard', "Meteo/Nonglard/sunset", sunset )


		-- refresh window's content
	srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	return self
end

Meteo = meteo()

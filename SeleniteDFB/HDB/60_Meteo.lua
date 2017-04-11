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
	srf:DrawLine( 305, ftitle:GetHeight() + 40, 305, WINSIZE[2] - 40 )
	y = y + 15

	local plus1 = stweather( srf, 0, y )
	local w1 = Weather3H(plus1, 'Meteo3H', 'Nonglard', 1)

	local plus2 = stweather( srf, plus1.getNext() + 5, y )
	local w2 = Weather3H(plus2, 'Meteo3H', 'Nonglard', 2)

	local plus3 = stweather( srf, plus2.getNext() + 5, y )
	local w3 = Weather3H(plus3, 'Meteo3H', 'Nonglard', 3)

	y = ftitle:GetHeight() 
	local day1 = ltweather( srf, 320, y )
	local d1 = Weather( day1, 'Meteo', 'Nonglard', 1)

	local day2 = ltweather( srf, day1.getNext() , y )
	local d2 = Weather( day2, 'Meteo', 'Nonglard', 2)

	local day3 = ltweather( srf, day2.getNext() , y )
	local d3 = Weather( day3, 'Meteo', 'Nonglard', 3)

	x,y = day1.getBellow()
	local day4 = ltweather( srf, x, y )
	local d4 = Weather( day4, 'Meteo', 'Nonglard', 4)

	local day5 = ltweather( srf, day4.getNext(), y )
	local d5 = Weather( day5, 'Meteo', 'Nonglard', 5)

	local day6 = ltweather( srf, day5.getNext(), y )
	local d6 = Weather( day6, 'Meteo', 'Nonglard', 6)

	x,y = day4.getBellow()
	y = y+5
	local gfxTDehors = GfxArea( srf,
		x, y, WINSIZE[1] - x, WINSIZE[2] - y,
		COL_GFXFG, COL_GFXBG,
		{
			align=ALIGN_RIGHT,
			vlines={ { 0, COL_DIGIT } },
			vevrylines={ {5, COL_DARKGREY}, { 10, COL_GREY } }
		}
	)
--	gfxTExt.get():FillGrandient { TopLeft={20,20,20,255}, BottomLeft={20,20,20,255}, TopRight={255,96,32,255}, BottomRight={32,255,32,255} }
	local TDehors = MQTTStoreGfx( 'TDehors', 'maison/Temperature/Dehors', LeftBar.srf_TDehors, gfxTDehors, nil,
		{
			gradient = GRD_TEMPERATURE,
			forced_min = 0,
			condition=condition_network
		}
	)
	function self.refreshGfx()
		gfxTDehors.refresh()
	end


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

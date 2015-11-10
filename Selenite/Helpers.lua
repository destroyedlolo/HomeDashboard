------
-- Helpers functions
------

--
-- Update text fields
--

function UpdDataRight( srf, data )
	local font = srf:GetFont()
	srf:Clear( unpack(COL_BLACK) )
	srf:DrawString( data, srf:GetWidth() - font:StringWidth(data), 0)
	font:Release()
end

function upddata( srf, font, data )
	srf:SetFont( font )
	srf:Clear( unpack(COL_BLACK) )
	srf:DrawString( data, srf:GetWidth() - font:StringWidth(data), 0)
end

function upddataCentered( srf, font, data )
	srf:SetFont( font )
	srf:Clear( unpack(COL_BLACK) )
	srf:DrawString( data, (srf:GetWidth() - font:StringWidth(data))/2, 0)
end


--
-- Update trend graphics
--

function updgfx( srf, data, amin )
	srf:Clear( 10,10,10, 255 )
	local min,max = data:MinMax()
	min = amin or min
	if max == min then	-- No dynamic data to draw
		return
	end
	local h = srf:GetHeight()-1
	local sy = h/(max-min) -- vertical scale
	local sx = srf:GetWidth()/data:GetSize()

	local y		-- previous value
	local x=0	-- x position
	for v in data:iData() do
		if y then
			x = x+1
			srf:DrawLine((x-1)*sx, h - (y-min)*sy, x*sx, h - (v-min)*sy)
		end
		y = v 
	end
end

--
-- Update weather's icons
--

WeatherImg = {}
function updmeteo( idx, iconid )
	if not WeatherImg[ iconid ] then
		local err
		WeatherImg[ iconid ],err = SelImage.create("/usr/local/share/WeatherIcons/" .. iconid .. ".png")
		if not WeatherImg[ iconid ] then
			print(err)
			return
		end
	end
	WeatherImg[ iconid ]:RenderTo( srf_Meteo[idx], { 0,0, 92,66 } )
end

function updmeteo3H( idx, iconid )
	if not WeatherImg[ iconid ] then
		local err
		WeatherImg[ iconid ],err = SelImage.create("/usr/local/share/WeatherIcons/" .. iconid .. ".png")
		if not WeatherImg[ iconid ] then
			print(err)
			return
		end
	end

	if idx == 1 then
		WeatherImg[ iconid ]:RenderTo( srf_Meteo3H[idx], { 0,0, 115, 82 } )
	else
		WeatherImg[ iconid ]:RenderTo( srf_Meteo3H[idx], { 0,0, 78, 56 } )
	end
end

--
-- Field update helpers
--

function updtime(num)
	local t=os.date("*t", tonumber(SelShared.get('Meteo3H/Nonglard/'.. num ..'/time')) )
	upddataCentered(srf_MeteoTime3H[num+1], fsdigit, string.format("%02d:%02d", t.hour, t.min))
end

function updtemp(num)
	local v=SelShared.get('Meteo3H/Nonglard/'.. num ..'/temperature')
	srf_MeteoTemp3H[num+1]:SetColor( findgradiancolor(v, cols_temperature ) )
	if num == 0 then
		upddata(srf_MeteoTemp3H[1], fdigit, string.format("%-3.1f", v) .. '°C')
	else
		upddata(srf_MeteoTemp3H[num+1], fsdigit, string.format("%-3.1f", v) .. '°C')
	end
end

function updwinds(num)
	upddata(srf_MeteoWind3H[num+1], fsdigit, string.format("%4.1f", SelShared.get("Meteo3H/Nonglard/"..num.."/wind/speed")*3.6))
end

function updatetime(num)
-- Update time 'num' field.
-- Num is the number of the MQTT chanel
	local wdays = {'Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'}

	local t=os.date("*t", SelShared.get('Meteo/Nonglard/'.. num ..'/time') )
	upddataCentered(srf_MeteoDate[num], fsdigit, wdays[t.wday] ..' '.. t.day ..'/'.. t.month)
end

function updatedtmax(num)
	local v=SelShared.get('Meteo/Nonglard/'.. num ..'/temperature/day')
	srf_MeteoTMax[num]:SetColor( findgradiancolor(v, cols_temperature ) )
	upddataCentered(srf_MeteoTMax[num], fsdigit, v .. '°C')
end

function updatedtmin(num)
	local v=SelShared.get('Meteo/Nonglard/'.. num ..'/temperature/night')
	srf_MeteoTMin[num]:SetColor( findgradiancolor(v, cols_temperature ) )
	upddataCentered(srf_MeteoTMin[num], fsdigit, v .. '°C')
end

--
-- Wind direction
--
function rot( s, a )	-- Rotate coordinates s by angle a
	return	s.x * math.cos(a) + s.y * math.sin(a),
			-s.x * math.sin(a) + s.y * math.cos(a)
end

function point( pos, a, c )	-- return the coordinate of 
							-- the point 'pos'
							-- rotated by 'a'
							-- centered on 'c'
	local x = pos.x * math.cos(a) + pos.y * math.sin(a)
	local y = -pos.x * math.sin(a) + pos.y * math.cos(a)
	return 	x * c + c,
			y * c + c
end

function drawWind(srf, dir)
	local dir = math.rad(-dir)	-- 0° is for the north and it's anti-clockwise

	local w,h = srf:GetSize()
	local c = w/2	-- Center coordinate

	local s1 = { x= -.35,	y= -.5 }
	local s2 = { x=    0,	y= -.5 }
	local s3 = { x=    0, 	y=  .5 }

	srf:Clear( unpack(COL_BLACK) )

	srf:SetColor( unpack(COL_ORANGE) )
	local x1,y1 = point( s1, dir, c)
	local x2,y2 = point( s2, dir, c)
	local x3,y3 = point( s3, dir, c)

	srf:FillTriangle( x1,y1, x2,y2, x3,y3 )

	srf:SetColor( unpack(COL_RED) )
	s1.x = .35
	x1,y1 = point( s1, dir, c)
	x2,y2 = point( s2, dir, c)
	x3,y3 = point( s3, dir, c)

	srf:FillTriangle( x1,y1, x2,y2, x3,y3 )
end

function updwindd( num )
	drawWind(srf_MeteoWindd3H[num+1], tonumber(SelShared.get('Meteo3H/Nonglard/'.. num ..'/wind/direction')) )
end

--[[
	x	x	-.25,-.5	0,-5

		x		0,0

		x		0,.5
]]

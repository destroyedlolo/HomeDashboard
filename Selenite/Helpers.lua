------
-- Helpers functions
------

--
-- Update text fields
--

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
	local min,max = data:MinMax()
	min = amin or min
	if max == min then	-- No dynamic data to draw
		return
	end
	local sy = srf:GetHeight()/(max-min) -- vertical scale
	local sx = srf:GetWidth()/data:GetSize()

	local y		-- previous value
	local x=0	-- x position
	srf:Clear( 10,10,10, 255 )
	for v in data:iData() do
		if y then
			x = x+1
			srf:DrawLine((x-1)*sx, srf:GetHeight() - (y-min)*sy, x*sx, srf:GetHeight() - (v-min)*sy)
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


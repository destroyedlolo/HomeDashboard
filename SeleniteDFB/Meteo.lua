-- This file define the window for meteo forcast

local window = layer:CreateWindow {
	pos = WINTOP, size = WINSIZE,
	caps=SelWindow.CapsConst('NONE'),
	surface_caps=SelSurface.CapabilityConst('NONE')
}
window:SetOpacity(0xff)			-- Make it visible
mto_srf = window:GetSurface()	-- Get its surface

table.insert( winlist, window )

-- compatibility with newer Lua
local unpack = unpack or table.unpack

-- Design
WeatherImg = {}

mto_srf:SetColor( unpack(COL_BORDER) )
mto_srf:SetFont( ftitle )
mto_srf:DrawString("Prévisions du jour", 0, 0)

local goffy = ftitle:GetHeight() + 10

srf_Meteo3H = {			-- Icon
	mto_srf:SubSurface( 0, goffy, 184, 128 )
}
mto_desc = mto_srf:SubSurface( 0, goffy + 129, 184, fsdigit:GetHeight())
mto_desc:SetColor( unpack(COL_DIGIT) )
mto_desc:SetFont( fsdigit )

mto_srf:SetFont( fsdigit )
mto_srf:DrawString("Pour :", 190, goffy)
srf_MeteoTime3H = { 	-- Time
	mto_srf:SubSurface( 190 + fsdigit:StringWidth("Pour : "), goffy, fsdigit:StringWidth("88:88"), fsdigit:GetHeight() )
}
goffy = goffy + fsdigit:GetHeight()

srf_MeteoTemp3H = {		-- Temperature
	mto_srf:SubSurface( 190, goffy, fdigit:StringWidth("-88:8°C"), fdigit:GetHeight() )
}
goffy = goffy + fdigit:GetHeight()

srf_MeteoWindd3H = {
	mto_srf:SubSurface( 190, goffy, fsdigit:GetHeight(), fsdigit:GetHeight() )
}

srf_MeteoWind3H = {
	mto_srf:SubSurface( 190 + fsdigit:GetHeight(), goffy, fsdigit:StringWidth("88:88"), fsdigit:GetHeight() )
}
mto_srf:DrawString(" km/h", 190 + fsdigit:GetHeight() + fsdigit:StringWidth("88:88"), goffy)
goffy = goffy + fsdigit:GetHeight()

WeatherImg['03d'] = SelImage.create("/usr/local/share/WeatherIcons/03d.png")
WeatherImg['03d']:RenderTo( mto_srf, { 190, goffy, fsdigit:GetHeight(), fsdigit:GetHeight() } )
srf_cloud = {
	mto_srf:SubSurface( 195 + fsdigit:GetHeight(), goffy, fsdigit:StringWidth("188%"), fsdigit:GetHeight() )
}
goffy = goffy + fsdigit:GetHeight()

local img,err = SelImage.create(SELENE_SCRIPT_DIR .."/Images/Goutte.png")
assert(img)
img:RenderTo( mto_srf, { 190, goffy, fsdigit:GetHeight(), fsdigit:GetHeight() } )
img:destroy()
mto_hydro = mto_srf:SubSurface( 195 + fsdigit:GetHeight(), goffy, fsdigit:StringWidth("188%"), fsdigit:GetHeight())
mto_hydro:SetColor( unpack(COL_DIGIT) )
mto_hydro:SetFont( fsdigit )
goffy = goffy + fsdigit:GetHeight() + 20

mto_srf:DrawLine( 20, goffy, 260, goffy )

goffy = goffy + 20

table.insert( srf_MeteoTime3H, mto_srf:SubSurface( 0, goffy, 92, fsdigit:GetHeight()) )
table.insert( srf_MeteoTime3H, mto_srf:SubSurface( 110, goffy, 92, fsdigit:GetHeight()) )
table.insert( srf_MeteoTime3H, mto_srf:SubSurface( 210, goffy, 92, fsdigit:GetHeight()) )
goffy = goffy + fsdigit:GetHeight()

table.insert( srf_Meteo3H, mto_srf:SubSurface( 0, goffy, 78, 54 ) )
table.insert( srf_Meteo3H, mto_srf:SubSurface( 110, goffy, 78, 54 ) )
table.insert( srf_Meteo3H, mto_srf:SubSurface( 210, goffy, 78, 54 ) )
goffy = goffy + 54

table.insert( srf_MeteoTemp3H, mto_srf:SubSurface( 0, goffy, 80, fsdigit:GetHeight() ) )
table.insert( srf_MeteoTemp3H, mto_srf:SubSurface( 110, goffy, 80, fsdigit:GetHeight() ) )
table.insert( srf_MeteoTemp3H, mto_srf:SubSurface( 210, goffy, 80, fsdigit:GetHeight() ) )
goffy = goffy + fsdigit:GetHeight()

table.insert( srf_MeteoWind3H, mto_srf:SubSurface( 0, goffy, 80 - fsdigit:GetHeight(), fsdigit:GetHeight() ) )
table.insert( srf_MeteoWind3H, mto_srf:SubSurface( 110, goffy, 80 - fsdigit:GetHeight(), fsdigit:GetHeight() ) )
table.insert( srf_MeteoWind3H, mto_srf:SubSurface( 210, goffy, 80 - fsdigit:GetHeight(), fsdigit:GetHeight() ) )

table.insert( srf_MeteoWindd3H, mto_srf:SubSurface( 80 - fsdigit:GetHeight(), goffy, fsdigit:GetHeight(), fsdigit:GetHeight() ) )
table.insert( srf_MeteoWindd3H, mto_srf:SubSurface( 190 - fsdigit:GetHeight(), goffy, fsdigit:GetHeight(), fsdigit:GetHeight() ) )
table.insert( srf_MeteoWindd3H, mto_srf:SubSurface( 290 - fsdigit:GetHeight(), goffy, fsdigit:GetHeight(), fsdigit:GetHeight() ) )
goffy = goffy + fsdigit:GetHeight()

table.insert( srf_cloud, mto_srf:SubSurface( 0, goffy, 80 - fsdigit:GetHeight(), fsdigit:GetHeight() ) )
table.insert( srf_cloud, mto_srf:SubSurface( 110, goffy, 80 - fsdigit:GetHeight(), fsdigit:GetHeight() ) )
table.insert( srf_cloud, mto_srf:SubSurface( 210, goffy, 80 - fsdigit:GetHeight(), fsdigit:GetHeight() ) )
WeatherImg['03d']:RenderTo( mto_srf, { 80 - fsdigit:GetHeight(), goffy, fsdigit:GetHeight(), fsdigit:GetHeight() } )
WeatherImg['03d']:RenderTo( mto_srf, { 190 - fsdigit:GetHeight(), goffy, fsdigit:GetHeight(), fsdigit:GetHeight() } )
WeatherImg['03d']:RenderTo( mto_srf, { 290 - fsdigit:GetHeight(), goffy, fsdigit:GetHeight(), fsdigit:GetHeight() } )

for i=1,4 do
	srf_MeteoTime3H[i]:SetColor( unpack(COL_DIGIT) )
	srf_MeteoTime3H[i]:SetFont( fsdigit )
	if i==1 then
		srf_MeteoTemp3H[i]:SetFont( fdigit )
	else
		srf_MeteoTemp3H[i]:SetFont( fsdigit )
	end
	srf_MeteoWind3H[i]:SetColor( unpack(COL_DIGIT) )
	srf_MeteoWind3H[i]:SetFont( fsdigit )

	srf_cloud[i]:SetColor( unpack(COL_DIGIT) )
	srf_cloud[i]:SetFont( fsdigit )
end

mto_srf:SetColor( unpack(COL_BORDER) )
mto_srf:DrawLine( 315, 40, 315, WINSIZE[2]-40 )

mto_srf:SetFont( ftitle )
mto_srf:DrawString("Jours à venir", 335, 0)
goffy = ftitle:GetHeight()

srf_Meteo = { 
	mto_srf:SubSurface( 330 , goffy, 82,54),
	mto_srf:SubSurface( 435 , goffy, 82,54),
	mto_srf:SubSurface( 540 , goffy, 82,54),

	mto_srf:SubSurface( 330 , goffy + 54 + 3*fsdigit:GetHeight(), 82,54),
	mto_srf:SubSurface( 435 , goffy + 54 + 3*fsdigit:GetHeight(), 82,54),
	mto_srf:SubSurface( 540 , goffy + 54 + 3*fsdigit:GetHeight(), 82,54)
}
goffy = goffy + 54

srf_MeteoDate = {
	mto_srf:SubSurface( 325, goffy, 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 430, goffy, 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 535, goffy, 92, fsdigit:GetHeight()),

	mto_srf:SubSurface( 325, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 430, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 535, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight())
}
goffy = goffy + fsdigit:GetHeight()

srf_MeteoTMax = {
	mto_srf:SubSurface( 325, goffy, 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 430, goffy, 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 535, goffy, 92, fsdigit:GetHeight()),

	mto_srf:SubSurface( 325, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 430, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 535, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight())
}
goffy = goffy + fsdigit:GetHeight()

srf_MeteoTMin = {
	mto_srf:SubSurface( 325, goffy, 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 430, goffy, 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 535, goffy, 92, fsdigit:GetHeight()),

	mto_srf:SubSurface( 325, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 430, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight()),
	mto_srf:SubSurface( 535, goffy + 54 + 3*fsdigit:GetHeight(), 92, fsdigit:GetHeight())
}
goffy = goffy + 54 + 4*fsdigit:GetHeight()

for i=1,6 do
	srf_MeteoDate[i]:SetColor( unpack(COL_DIGIT) )
	srf_MeteoDate[i]:SetFont( fsdigit )

	srf_MeteoTMax[i]:SetColor( unpack(COL_DIGIT) )
	srf_MeteoTMax[i]:SetFont( fsdigit )

	srf_MeteoTMin[i]:SetColor( unpack(COL_DIGIT) )
	srf_MeteoTMin[i]:SetFont( fsdigit )
end

srf_TDehorsGfx = mto_srf:SubSurface( 325, goffy, WINSIZE[1] - 325, WINSIZE[2] - goffy)
srf_TDehorsGfx:SetFont( fsdigit )
dt_TDehors = SelCollection.create( srf_TDehorsGfx:GetWidth() )

-- Update functions
function mtosrfupdate()
	mto_srf:Flip(SelSurface.FlipFlagsConst("NONE"))
end

function updateTDehors()
	local v = SelShared.get('maison/Temperature/Dehors')
	dt_TDehors:Push( v )
	updFGfx( srf_TDehorsGfx, dt_TDehors, 0 )

		-- Update on the primary surface
	upddata( srf_TDehors, fdigit, v .. "°C" )
	SelShared.PushTask( psrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updmeteo( idx, iconid )
	if not WeatherImg[ iconid ] then
		local err
		WeatherImg[ iconid ],err = SelImage.create("/usr/local/share/aWeatherIcons/" .. iconid .. ".png")
		if not WeatherImg[ iconid ] then
			print(err)
			return
		end
	end
	WeatherImg[ iconid ]:RenderTo( srf_Meteo[idx], { 0,0, 77,54 } )
end

function updmeteo3H( idx, iconid )
	if not WeatherImg[ iconid ] then
		local err
		WeatherImg[ iconid ],err = SelImage.create("/usr/local/share/aWeatherIcons/" .. iconid .. ".png")
		if not WeatherImg[ iconid ] then
			print(err)
			return
		end
	end

	if idx == 1 then
		WeatherImg[ iconid ]:RenderTo( srf_Meteo3H[idx], { 0,0, 184, 131 } )
	else
		WeatherImg[ iconid ]:RenderTo( srf_Meteo3H[idx], { 0,0, 77, 54 } )
	end

	SelShared.PushTask( mtosrfupdate, SelShared.TaskOnceConst("LAST"))
end

--
-- Field update helpers
--

function updtime(num)
	local t=os.date("*t", tonumber(SelShared.get('Meteo3H/Nonglard/'.. num ..'/time')) )
	UpdDataCentered(srf_MeteoTime3H[num+1], string.format("%02d:%02d", t.hour, t.min))
	SelShared.PushTask( mtosrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updtemp(num)
	local v=SelShared.get('Meteo3H/Nonglard/'.. num ..'/temperature')
	srf_MeteoTemp3H[num+1]:SetColor( findgradiancolor(v, cols_temperature ) )
	UpdDataRight(srf_MeteoTemp3H[num+1], string.format("%-3.1f", v) .. '°C' )

	SelShared.PushTask( mtosrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updwinds(num)
	UpdDataRight(srf_MeteoWind3H[num+1], string.format("%4.1f", SelShared.get("Meteo3H/Nonglard/"..num.."/wind/speed")*3.6))
end

function updclouds( num )
	UpdDataRight( srf_cloud[num+1], SelShared.get('Meteo3H/Nonglard/'..num..'/clouds')..'%' )
	SelShared.PushTask( mtosrfupdate, SelShared.TaskOnceConst("LAST"))
end

function updatetime(num)
-- Update time 'num' field.
-- Num is the number of the MQTT chanel
	local wdays = {'Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'}

	local t=os.date("*t", SelShared.get('Meteo/Nonglard/'.. num ..'/time') )
	UpdDataCentered(srf_MeteoDate[num], wdays[t.wday] ..' '.. t.day ..'/'.. t.month)
end

function updatedtmax(num)
	local v=SelShared.get('Meteo/Nonglard/'.. num ..'/temperature/day')
	srf_MeteoTMax[num]:SetColor( findgradiancolor(v, cols_temperature ) )
	UpdDataCentered(srf_MeteoTMax[num], v .. '°C')
end

function updatedtmin(num)
	local v=SelShared.get('Meteo/Nonglard/'.. num ..'/temperature/night')
	srf_MeteoTMin[num]:SetColor( findgradiancolor(v, cols_temperature ) )
	UpdDataCentered(srf_MeteoTMin[num], v .. '°C')
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

function upd0Icn()
	updmeteo3H( 1, SelShared.get('Meteo3H/Nonglard/0/weather/acode' ) )
end

function upd0Desc()
	UpdDataCentered( mto_desc, SelShared.get('Meteo3H/Nonglard/0/weather/description' ) )
	SelShared.PushTask( mtosrfupdate, SelShared.TaskOnceConst("LAST"))
end

function upd0time()
	updtime(0)
end

function upd0temp()
	updtemp(0)
end

function upd0winds()
	updwinds(0)
end

function upd0windd()
	updwindd(0)
end

function upd0clouds()
	updclouds(0)
end

function upd0hum()
	UpdDataRight( mto_hydro, SelShared.get('Meteo3H/Nonglard/0/humidity')..'%' )
	SelShared.PushTask( mtosrfupdate, SelShared.TaskOnceConst("LAST"))
end

function upd1Icn()
	updmeteo3H( 2, SelShared.get('Meteo3H/Nonglard/1/weather/acode' ) )
end

function upd1time()
	updtime(1)
end

function upd1temp()
	updtemp(1)
end

function upd1winds()
	updwinds(1)
end

function upd1windd()
	updwindd(1)
end

function upd1clouds()
	updclouds(1)
end

function upd2Icn()
	updmeteo3H( 3, SelShared.get('Meteo3H/Nonglard/2/weather/acode' ) )
end

function upd2time()
	updtime(2)
end

function upd2temp()
	updtemp(2)
end

function upd2winds()
	updwinds(2)
end

function upd2windd()
	updwindd(2)
end

function upd2clouds()
	updclouds(2)
end

function upd3Icn()
	updmeteo3H( 4, SelShared.get('Meteo3H/Nonglard/3/weather/acode' ) )
end

function upd3time()
	updtime(3)
end

function upd3temp()
	updtemp(3)
end

function upd3winds()
	updwinds(3)
end

function upd3windd()
	updwindd(3)
end

function upd3clouds()
	updclouds(3)
end

function updated0Icn()
	updmeteo( 1, SelShared.get('Meteo/Nonglard/1/weather/acode' ) )
end

function updated0time()
	updatetime(1)
end

function updated0tmax()
	updatedtmax(1)
end

function updated0tmin()
	updatedtmin(1)
end

function updated1Icn()
	updmeteo( 2, SelShared.get('Meteo/Nonglard/2/weather/acode' ) )
end

function updated1time()
	updatetime(2)
end

function updated1tmax()
	updatedtmax(2)
end

function updated1tmin()
	updatedtmin(2)
end

function updated2Icn()
	updmeteo( 3, SelShared.get('Meteo/Nonglard/3/weather/acode' ) )
end

function updated2time()
	updatetime(3)
end

function updated2tmax()
	updatedtmax(3)
end

function updated2tmin()
	updatedtmin(3)
end

function updated3Icn()
	updmeteo( 4, SelShared.get('Meteo/Nonglard/4/weather/acode' ) )
end

function updated3time()
	updatetime(4)
end

function updated3tmax()
	updatedtmax(4)
end

function updated3tmin()
	updatedtmin(4)
end

function updated4Icn()
	updmeteo( 5, SelShared.get('Meteo/Nonglard/5/weather/acode' ) )
end

function updated4time()
	updatetime(5)
end

function updated4tmax()
	updatedtmax(5)
end

function updated4tmin()
	updatedtmin(5)
end

function updated5Icn()
	updmeteo( 6, SelShared.get('Meteo/Nonglard/6/weather/acode' ) )
end

function updated5time()
	updatetime(6)
end

function updated5tmax()
	updatedtmax(6)
end

function updated5tmin()
	updatedtmin(6)
end


-- local subscription
local ltopics = {
	{ topic = "maison/Temperature/Dehors", trigger=updateTDehors, trigger_once=true },

	{ topic = "Meteo3H/Nonglard/0/weather/acode", trigger=upd0Icn, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/0/weather/description", trigger=upd0Desc, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/0/time", trigger=upd0time, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/0/temperature", trigger=upd0temp, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/0/wind/speed", trigger=upd0winds, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/0/wind/direction", trigger=upd0windd, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/0/clouds", trigger=upd0clouds, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/0/humidity", trigger=upd0hum, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/1/weather/acode", trigger=upd1Icn, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/1/time", trigger=upd1time, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/1/temperature", trigger=upd1temp, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/1/wind/speed", trigger=upd1winds, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/1/wind/direction", trigger=upd1windd, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/1/clouds", trigger=upd1clouds, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/2/weather/acode", trigger=upd2Icn, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/2/time", trigger=upd2time, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/2/temperature", trigger=upd2temp, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/2/wind/speed", trigger=upd2winds, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/2/wind/direction", trigger=upd2windd, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/2/clouds", trigger=upd2clouds, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/3/weather/acode", trigger=upd3Icn, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/3/time", trigger=upd3time, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/3/temperature", trigger=upd3temp, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/3/wind/speed", trigger=upd3winds, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/3/wind/direction", trigger=upd3windd, trigger_once=true },
	{ topic = "Meteo3H/Nonglard/3/clouds", trigger=upd3clouds, trigger_once=true },
	{ topic = "Meteo/Nonglard/1/weather/acode", trigger=updated0Icn, trigger_once=true },
	{ topic = "Meteo/Nonglard/2/weather/acode", trigger=updated1Icn, trigger_once=true },
	{ topic = "Meteo/Nonglard/3/weather/acode", trigger=updated2Icn, trigger_once=true },
	{ topic = "Meteo/Nonglard/4/weather/acode", trigger=updated3Icn, trigger_once=true },
	{ topic = "Meteo/Nonglard/5/weather/acode", trigger=updated4Icn, trigger_once=true },
	{ topic = "Meteo/Nonglard/6/weather/acode", trigger=updated5Icn, trigger_once=true },
	{ topic = "Meteo/Nonglard/1/time", trigger=updated0time, trigger_once=true },
	{ topic = "Meteo/Nonglard/2/time", trigger=updated1time, trigger_once=true },
	{ topic = "Meteo/Nonglard/3/time", trigger=updated2time, trigger_once=true },
	{ topic = "Meteo/Nonglard/4/time", trigger=updated3time, trigger_once=true },
	{ topic = "Meteo/Nonglard/5/time", trigger=updated4time, trigger_once=true },
	{ topic = "Meteo/Nonglard/6/time", trigger=updated5time, trigger_once=true },
	{ topic = "Meteo/Nonglard/1/temperature/day", trigger=updated0tmax, trigger_once=true },
	{ topic = "Meteo/Nonglard/2/temperature/day", trigger=updated1tmax, trigger_once=true },
	{ topic = "Meteo/Nonglard/3/temperature/day", trigger=updated2tmax, trigger_once=true },
	{ topic = "Meteo/Nonglard/4/temperature/day", trigger=updated3tmax, trigger_once=true },
	{ topic = "Meteo/Nonglard/5/temperature/day", trigger=updated4tmax, trigger_once=true },
	{ topic = "Meteo/Nonglard/6/temperature/day", trigger=updated5tmax, trigger_once=true },
	{ topic = "Meteo/Nonglard/1/temperature/night", trigger=updated0tmin, trigger_once=true },
	{ topic = "Meteo/Nonglard/2/temperature/night", trigger=updated1tmin, trigger_once=true },
	{ topic = "Meteo/Nonglard/3/temperature/night", trigger=updated2tmin, trigger_once=true },
	{ topic = "Meteo/Nonglard/4/temperature/night", trigger=updated3tmin, trigger_once=true },
	{ topic = "Meteo/Nonglard/5/temperature/night", trigger=updated4tmin, trigger_once=true },
	{ topic = "Meteo/Nonglard/6/temperature/night", trigger=updated5tmin, trigger_once=true }
}

TableMerge( Topics, ltopics)
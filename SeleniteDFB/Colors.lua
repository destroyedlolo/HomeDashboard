-- Define frequently used colors
-- (based on HTML color names)

COL_BLACK = { 0,0,0, 0xff }
COL_RED = { 0xff,0x0f,0x0f, 0xff }
COL_ORANGE = { 0xff,0x8c,0x00, 0xff }
COL_GREEN = { 0x00,0xc6,0x00, 0xff }
COL_GREY = { 0x20, 0x20, 0x20, 0xff }
COL_LIGHTGREY = { 0x80, 0x80, 0x80, 0xff }
COL_WHITE = { 0xff, 0xff, 0xff, 0xff }

COL_BORDER = { 0x00,0x20,0xff, 0xff }
COL_TITLE = { 0x46,0x82,0xb4, 0xff }	-- SteelBlue
COL_DIGIT = { 0x00,0xff,0xff, 0xff }

COL_REDD = { 0x40,0x04,0x04, 0xff }
COL_ORANGED = { 0x40,0x23,0x00, 0xff }
COL_GREEND = { 0x00,0x31,0x00, 0xff }
COL_DIGITD = { 0x00,0x40,0x40, 0xff }

-- shared color gradiant

cols_temperature = {
		[15] = COL_DIGIT,
		[21] = COL_GREEN,
		[25] = COL_ORANGE,
		[30] = COL_RED
}

-- Find color b/w 2 known values
-- key = known value
-- value = corresponding color (table)

local function linearcolor( val, u1, v1, u2, v2)
	if u1 == u2 then
		return u1
	else	-- Linear function col = a*val+b
		local a,b
		a = (v2-v1)/(u2-u1)
		b = v1 - a*u1
		return (a*val + b)
	end
end

function findgradiancolor( val, colors )
	val = tonumber(val)
	if colors[val] then
		return unpack(colors[val])
	end

	local keys={}
	for k, _ in pairs( colors ) do
		table.insert(keys, k)
	end
	table.sort( keys )

	local pre, post	-- previous and next color
	for i,k in ipairs(keys) do
		if k > val then
			pre = keys[i-1]
			post = k
			break
		end
	end

	if pre and post then -- linear function
		return 
			linearcolor( val, pre, colors[pre][1], post, colors[post][1] ),
			linearcolor( val, pre, colors[pre][2], post, colors[post][2] ),
			linearcolor( val, pre, colors[pre][3], post, colors[post][3] ),
			linearcolor( val, pre, colors[pre][4], post, colors[post][4] )
	elseif post then -- post without pre : 1st value
		return unpack(colors[keys[1]])
	else
		return unpack(colors[keys[#keys]])
	end
end

-- Font used
ftitle = SelFont.create("/usr/local/share/fonts/CarroisGothic-Regular.ttf", { height=30} )
ftitle1 = SelFont.create("/usr/local/share/fonts/Capsuula.ttf", { height=20} )
fdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=35} )
fmdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=30} )
fsdigit = SelFont.create("/usr/local/share/fonts/Abel-Regular.ttf", { height=20} )


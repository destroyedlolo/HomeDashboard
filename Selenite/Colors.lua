-- Define frequently used colors
-- (based on HTML color names)

COL_BLACK = { 0,0,0, 0xff }
COL_ORANGE = { 0xff,0x8c,0x00, 0xff }
COL_GREY = { 0x20, 0x20, 0x20, 0xff }
COL_WHITE = { 0xff, 0xff, 0xff, 0xff }

COL_BORDER = { 0x00,0x20,0xff, 0xff }
COL_TITLE = { 0x46,0x82,0xb4, 0xff }	-- SteelBlue
COL_DIGIT = { 0x00,0xff,0xff, 0xff }

-- Find color b/w 2 known values
-- key = known value
-- value = corresponding color (table)
function findcolor( val, colors )
	if colors[val] then
return('exact value')
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
return('linear function')
	elseif post then -- post without pre : 1st value
return('post without pre : 1st value')
	else
return('last value')
	end
end


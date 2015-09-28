-- Define frequently used colors
-- (based on HTML color names)

COL_BLACK = { 0,0,0, 0xff }
COL_RED = { 0xff,0x0f,0x0f, 0xff }
COL_ORANGE = { 0xff,0x8c,0x00, 0xff }
COL_GREEN = { 0x00,0xc6,0x00, 0xff }
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
		return(colors[val])
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
-- Voir https://fr.wikipedia.org/wiki/%C3%89quation_de_droite
-- Par résolution d'un système d'équations
	elseif post then -- post without pre : 1st value
print('premier', keys[1])
		return(colors[keys[1]])
	else
print('dernier', keys[#keys])
		return(colors[keys[#keys]])
	end
end


------
-- Helpers functions
------

-- merge t2 in t1
function TableMerge( t1, t2 )
	for _,v in ipairs(t2) do
		table.insert(t1, v)
	end

	return t1
end

--
-- Update text fields
--

function UpdDataRight( srf, data, col )
	local font = srf:GetFont()
	if not col then
		srf:Clear( unpack(COL_BLACK) )
	else
		srf:Clear( unpack(col) )
	end
	srf:DrawString( data, srf:GetWidth() - font:StringWidth(data), 0)
	font:Release()
end

function UpdDataCentered( srf, data )
	local font = srf:GetFont()
	srf:Clear( unpack(COL_BLACK) )
	srf:DrawString( data, (srf:GetWidth() - font:StringWidth(data))/2, 0)
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

function updgfx( srf, data, amin )	-- Minimal graphics
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

function updFGfx( srf, data, amin ) -- Full graphics
	local font = srf:GetFont()
	srf:Clear( 10,10,10, 255 )
	local vmin,max = data:MinMax()
	if amin or vmin > amin then
		min = amin
	else
		min = vmin
	end
	local h = srf:GetHeight()-1

	srf:SetColor( unpack(COL_BORDER) )
	srf:DrawString( string.format("%.1f",max) .. '°C', 0,0 )
	srf:DrawString( string.format("%.1f",vmin) .. '°C', 0, h - font:GetHeight())

	if max == min then	-- No dynamic data to draw
		return
	end
	
	local sy = h/(max-min) -- vertical scale
	local sx = srf:GetWidth()/data:GetSize()
	
	srf:SetColor( unpack(COL_DIGIT) )	-- Draw a line for 0
	srf:DrawLine(0, h + min*sy, srf:GetWidth(), h + min*sy)

	local y		-- previous value
	local x=0	-- x position
	srf:SetColor( unpack(COL_RED) )
	for v in data:iData() do
		if y then
			x = x+1
			srf:DrawLine((x-1)*sx, h - (y-min)*sy, x*sx, h - (v-min)*sy)
		end
		y = v 
	end
end

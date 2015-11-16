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

-- Arc as Percentage Gauge

function ArcGaugePercent(
	psrf,	-- mother surface
	sx,sy,	-- surrounding box position in the mother surface
	sw,sh,	-- its size
	width,	-- arc width
	quarter,	-- quarter number (see Selene's DrawCircle())
	opts
)
--[[ known options :
--	bgcolor : color outside the gauge
--	emptycolor : color for empty area
--]]
	if not opts then
		opts = {}
	end
	if not opts.bgcolor then
		opts.bgcolor = COL_BLACK
	end
	if not opts.emptycolor then
		opts.emptycolor = opts.bgcolor
	end

	local self = SubSurface(psrf, sx,sy, sw,sh )

	------
	-- mask
	-----
		-- ARGB add an alpha layer to the created surface
	local mask = SelSurface:create { size = { sw,sh }, pixelformat=SelSurface.PixelFormatConst('ARGB') }

	-- arc stuffs
	local cx,cy
	if quarter == 1 then	-- bottom left
		cx,cy = 0,sh
	elseif quarter == 2 then	-- bottom right
		cx,cy = sw,sh
	elseif quarter == 3 then	-- top right
		cx,cy = sw,0
	else					-- top left
		cx,cy = 0,0
	end
	local radius = sw
	if sh < sw then
		radius = sh
	end

	-- draw arc
	mask:Clear( opts.bgcolor.get() )
	mask:SetColor( 255,255,255, 0 )
	mask:FillCircle( cx,cy, radius, SelSurface.CircleQuarterConst('Q'..quarter) )
	mask:SetColor( opts.bgcolor.get() )
	mask:FillCircle( cx,cy, radius-10, SelSurface.CircleQuarterConst('Q'..quarter) )

	-------
	-- Graphics
	-------
	function self.Clear()
		self.get():Clear( opts.emptycolor.get() )
	end

	function self.ApplyMask()
		self.get():SetBlittingFlags( SelSurface.BlittingFlagsConst('BLEND_ALPHACHANNEL') )
		self.get():Blit( mask, nil, 0,0 )
		self.get():SetBlittingFlags( SelSurface.BlittingFlagsConst('NONE') )
	end

	function self.update( c, t, i )
		self.Clear()
		print("c:" .. c, "t:".. t, "i:".. i)
		self.ApplyMask()
	end

	return self
end

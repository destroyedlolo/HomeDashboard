-- Arc as Percentage Gauge

function ArcGaugePercent(
	psrf,	-- mother surface
	sx,sy,	-- surrounding box position in the mother surface
	sw,sh,	-- its size
	width,	-- arc width
	bgcolor,	-- background color
	quarter,	-- quarter number (see Selene's DrawCircle())
	opts
)
--[[ known options  :
--]]
	if not opts then
		opts = {}
	end

	local self = SubSurface(psrf, sx,sy, sw,sh )

	function self.Clear()
		self.get():Clear( bgcolor.get() )
	end

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
self.setColorRGB(255,255,255,255)
	self.get():FillCircle( cx,cy, radius, SelSurface.CircleQuarterConst('Q'..quarter) )
self.setColorRGB(0,0,0,255)
	self.get():FillCircle( cx,cy, radius-10, SelSurface.CircleQuarterConst('Q'..quarter) )

	return self
end

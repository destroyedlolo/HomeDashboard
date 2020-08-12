-- Display a temperature and associated gfx

function TempArea(
	psrf,	-- mother surface
	name, topic,
	x,y,	-- position in the mother surface
	opts
)
--[[ known options  :
--	width, height : force the field's geometry
--	bgcolor : background color
--	timeout : force to timeoutcolor after timeout seconds without update
--	transparency : the surfaces below must be refreshed as this one has 
--		transparency. With this opt set, surfaces bellow are cleared first.
--		Mostly useful when it has background image.
--
--	At last one of sample_text or width MUST be provided
--]]
	if not opts then
		opts = {}
	end

	if not opts.width then
		opts.width = 120
	end
	if not opts.height then
		opts.height = 80
	end
	if not opts.font then
		opts.font = fonts.mdigit
	end

		-- Normalisation
	x,y = math.ceil(x), math.ceil(y)
	opts.width = math.ceil( opts.width )
	opts.height = math.ceil( opts.height )

	if not opts.bgcolor then
		opts.bgcolor = COL_TRANSPARENT40
	end

	local self = Surface(psrf, x,y, opts.width, opts.height, opts)
	self.Visibility(true)

	function self.Clear(
		clipped -- clipping area from child (optional)
	)
		if psrf.Clear and opts.transparency then
			if clipped then	-- Offset this surface
				clipped[1] = clipped[1]+x
				clipped[2] = clipped[2]+y
			else
				clipped = { x,y, opts.width, opts.height }
			end
			psrf.Clear(clipped)
		end

		self.get():Clear( opts.bgcolor.get() )	-- Then clear ourself

		self.setColor( COL_BORDER )
		self.get():DrawRectangle(0,0, opts.width, opts.height)
	end

	local srf_Temp = FieldBlink( self, animTimer, 2, 2, opts.font, COL_DIGIT, {
		timeout = 310,
		width = opts.width - 4,
		align = ALIGN_RIGHT, 
		gradient = GRD_TEMPERATURE,
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
	} )

	local srf_Gfx = GfxArea( self, 2, 2+srf_Temp.getHight(), opts.width-4, opts.height-srf_Temp.getHight()-4 , COL_ORANGE, COL_TRANSPARENT,{
		heverylines={ {500, COL_DARKGREY} },
		align = ALIGN_RIGHT,
		ownsurface = true,
		transparency = true,
		gradient = GRD_TEMPERATURE
	} )

	local production = MQTTStoreGfx( name, topic, srf_Temp, srf_Gfx,
		{
			condition=condition_network 
		}
	)

	self.Clear()
	self.Refresh()

	return self
end

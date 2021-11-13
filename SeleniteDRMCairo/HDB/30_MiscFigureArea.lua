-- Generic graphics display

function MiscFigureArea(
	psrf,	-- mother surface
	name, topic,
	x,y,	-- position in the mother surface
	opts
)
--[[ known options  :
--
--		Global options
--		--------------
--
--	width, height : force the area's geometry
--	bgcolor : background color (default : COL_TRANSPARENT20)
--	color : color if no gradient (default : COL_DIGIT)
--	border : border's color (default none)
--	transparency : the surfaces below must be refreshed as this one has 
--		transparency. With this opt set, surfaces bellow are cleared first.
--		Mostly useful when it has background image.
--	shadow : add a shadow to the area
--	gradient : gradient to use (default none)
--	save_locally : retrieve from local backup
--	icon : SelDCSurfaceImage image to be placed at the right of the field
--
--		Figure field options
--		--------------------
--	
--	all Field's are applicable, but
--
--	figure_bgcolor : replace bgcolor (default : COL_TRANSPARENT40)
--	figure_gradient : default : global gradient
--	figure_color : default : global color
--	
--	If sample_text is not set, it use global width
--
--]]

	if not opts then
		opts = {}
	end
	if opts.debug then
		opts.debug = opts.debug .."/MiscFigureArea"
	end

		-- default options' values
	if not opts.width then
		opts.width = 120
	end
	if not opts.height then
		opts.height = 80
	end
	if not opts.font then
		opts.font = fonts.mdigit
	end
	if not opts.bgcolor then
		opts.bgcolor = COL_TRANSPARENT20
	end
	if not opts.color then
		opts.color = COL_DIGIT
	end

		-- default figure's values
	if not opts.figure_bgcolor then
		opts.figure_bgcolor = COL_TRANSPARENT40
	end
	if not opts.figure_gradient then
		opts.figure_gradient = opts.gradient
	end
	if not opts.figure_color then
		opts.figure_color = opts.color
	end

		-- Normalisation
	x,y = math.ceil(x), math.ceil(y)
	opts.width = math.ceil( opts.width )
	opts.height = math.ceil( opts.height )
	local w,h = opts.width, opts.height

	if opts.shadow then
		w = w+5
		h = h+5
	end

		-- main surface
	local self = Surface(psrf, x,y, w,h, opts)
	self.Visibility(true)

		-- icon's area
	local icon = ImageSurface( self,
		w - opts.font.size, 2,	-- "sizeof("100.00%") + some room"
		opts.font.size, opts.font.size, 
		{ autoscale=true } 
	)

	function self.Clear(
		clipped -- clipping area from child (optional)
	)
		local full = true
		if clipped then
			self.get():SaveContext()
			self.get():SetClipS( unpack(clipped) )
			full = false
		end

		if psrf.Clear and opts.transparency then
			if clipped then	-- Offset this surface
				clipped[1] = clipped[1]+x
				clipped[2] = clipped[2]+y
			else
				clipped = { x,y, opts.width, opts.height }
			end
			psrf.Clear({ clipped[1],clipped[2],clipped[3],clipped[4] })
		end

		self.get():Clear( opts.bgcolor.get() )	-- Then clear ourself

		if opts.shadow then
			self.setColor( COL_TRANSPARENT60 )
			self.get():FillRectangle( opts.width,5, opts.width+5, opts.height+5 )
			self.get():FillRectangle( 5,opts.height, opts.width+5, opts.height+5 )
		end

		if opts.border then
			self.setColor( opts.border )
			self.get():DrawRectangle(0,0, opts.width, opts.height)
		end

		if opts.icon then
				-- Refresh() is not enough as ImageSurface is a SubSurface only
				-- consequently, the "image" is destroyed every time the parent
				-- surface is cleared
			icon.Update( opts.icon )
		end
	
		if not full then
			self.get():RestoreContext()
		end
	end

	local srf_field = Field( self,
		math.max(2,w - opts.font.size), 2, 
		opts.font, opts.figure_color, {
			timeout = opts.timeout,
			timeoutcolor = opts.timeoutcolor,
			sample_text = opts.sample_text,
			ndecimal = opts.ndecimal,
			suffix = opts.suffix,
			align = ALIGN_FRIGHT,
			gradient = opts.figure_gradient,
			bgcolor = opts.figure_bgcolor,
			transparency = true,
			debug = opts.debug
		}
	)

	local srf_Gfx = GfxArea( self,
		2, 2+srf_field.getHight(),
		opts.width-4, opts.height-srf_field.getHight()-4,
		opts.color, opts.bgcolor,{
			heverylines = opts.heverylines,
			align = opts.align,
			transparency = true,
			min_delta = opts.min_delta,
			gradient = opts.gradient
		}
	)

	local dt = MQTTStoreGfx( name, topic, srf_field, srf_Gfx,
		{
			condition=condition_network,
			save_locally = opts.save_locally
		}
	)
	table.insert( savedcols, dt )

	---
	self.Clear()
	self.Refresh()

	return self
end

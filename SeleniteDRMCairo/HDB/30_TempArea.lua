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
--	border : border's color (default none)
--	timeout : force to timeoutcolor after timeout seconds without update
--	transparency : the surfaces below must be refreshed as this one has 
--		transparency. With this opt set, surfaces bellow are cleared first.
--		Mostly useful when it has background image.
--	shadow : add a shadow to the area
--	gradient : gradient to use (default GRD_TEMPERATURE)
--
--	TempTracking : token used for this room temperature tracker
--	ModeTopic : topic to follow room's mode
--
--	At last one of sample_text or width MUST be provided
--]]
	if not opts then
		opts = {}
	end
	if opts.debug then
		opts.debug = opts.debug .."/TempArea"
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
	if not opts.gradient then
		opts.gradient = GRD_TEMPERATURE
	end
	if not opts.timeout then
		opts.timeout = 310
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

	if not opts.bgcolor then
		opts.bgcolor = COL_TRANSPARENT20
	end

	local self = Surface(psrf, x,y, w,h, opts)
	self.Visibility(true)

	function self.Clear(
		clipped -- clipping area from child (optional)
	)
		local full = true
		if clipped then
			self.get():SaveContext()
			self.get():SetClipS( unpack(clipped) )
			full = false
		end
if opts.debug then
	if full then
print(opts.debug, "(TA)clear Full")
	else
print(opts.debug, "(TA)clear clip", unpack(clipped) )
	end
end

		if psrf.Clear and opts.transparency then
			if clipped then	-- Offset this surface
				clipped[1] = clipped[1]+x
				clipped[2] = clipped[2]+y
			else
				clipped = { x,y, opts.width, opts.height }
			end
if opts.debug then
print(opts.debug, "(TA)clear parent", unpack(clipped) )
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

		if not full then
			self.get():RestoreContext()
		end
if opts.debug then
print(opts.debug, "(TA)fin clear", unpack(clipped) )
end
	end

	if opts.TempTracking then
		local Surveillance = ImageStencilSurface( self, 0,0, SELENE_SCRIPT_DIR .. "/Images/Oeil.png", { debug = opts.debug } )
		self.srvtemp = Condition( Surveillance, 0, { issue_color=COL_ORANGE } )
		SuiviTracker("Suivi ".. name, opts.TempTracking, self.srvtemp, nil)
	end

	if opts.ModeTopic then
		Mode( self, "Mode_"..name, opts.ModeTopic, 0, 15, { width=20, hight=20, autoscale=true } );
	end

	local srf_Temp = Field( self,
		20, 2, opts.font, COL_DIGIT, {
			timeout = opts.timeout,
			width = opts.width - 24,
			align = ALIGN_RIGHT, 
			gradient = opts.gradient,
			bgcolor = COL_TRANSPARENT40,
			transparency = true,
--			debug = opts.debug
		} 
	)

	local srf_Gfx = GfxArea( self,
		2, 2+srf_Temp.getHight(),
		opts.width-4, opts.height-srf_Temp.getHight()-4,
		COL_ORANGE, COL_TRANSPARENT20,{
			heverylines={ {500, COL_DARKGREY} },
			align = ALIGN_RIGHT,
			transparency = true,
			min_delta = 1,
			gradient = opts.gradient
		}
	)

	local temp = MQTTStoreGfx( name, topic, srf_Temp, srf_Gfx,
		{
			condition=condition_network 
		}
	)
	table.insert( savedcols, temp )

	---
	self.Clear()
	self.Refresh()

	return self
end

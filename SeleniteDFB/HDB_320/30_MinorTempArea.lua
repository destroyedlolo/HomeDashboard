-- Display a minor temperature graphics

function MinorTempArea(
	srf,	-- parent surface
	name, topic,
	x,y,	-- top left of this area
	opts
)
--[[ known options  :
	font : font to use to display (default fdigit)
	title : title to display
	size : size of the area

	Ether title or size have to be present

	group : groups data by 'group' seconds
--]]
	if not opts then
		opts = {}
	end
	if not opts.font then
		opts.font = fdigit
	end
	if opts.title then
		srf:SetColor( COL_TITLE.get() )
		srf:SetFont( ftitle1 )
		srf:DrawString(opts.title, x, y)
		if not opts.size then
			opts.size = ftitle1:StringWidth(opts.title)
		end
		y = y + ftitle1:GetHeight()
	end
	if not opts.gradient then
		opts.gradient = GRD_TEMPERATURE
	end

	local srf_Temp = FieldBlink( srf, animTimer,
		x + opts.size, y, opts.font, COL_DIGIT, {
			timeout = 360,
			align = ALIGN_FRIGHT,
			gradient = opts.gradient,
			sample_text = "-88.8"
	})
	_,y = srf_Temp.get():GetBelow()

	local srf_gfx = GfxArea( srf, x, y, opts.size, HSGRPH, COL_TRANSPARENT, COL_GFXBG, { align=ALIGN_RIGHT, min_delta = opts.min_delta } )
	srf_gfx.get():FillGrandient { TopLeft={20,20,20,255}, BottomLeft={20,20,20,255}, TopRight={255,100,32,255}, BottomRight={32,255,32,255} }
	srf_gfx.FrozeUnder()

	local self = MQTTStoreGfx( name, topic, srf_Temp, srf_gfx, 
		{
			group = opts.group
		}
	)
	table.insert( savedcols, self )

	function self.getBelow()
		return srf_gfx.ownsrf():GetBelow()
	end

	function self.getAfter()
		return x + opts.size
	end

	function self.getSize()
		return opts.size
	end

	return self
end

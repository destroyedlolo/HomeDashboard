-- Display a minor temperature graphics

function MintorTempArea(
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

	srf_Temp = FieldBlink( srf, animTimer,
		x + opts.size - opts.font:StringWidth("°C"), y, opts.font, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8"
	})
	srf:SetFont( opts.font )
	srf:DrawString("°C", srf_Temp.get():GetAfter() )
	_,y = srf_Temp.get():GetBelow()

	local srf_gfx = GfxArea( srf, x, y, opts.size, HSGRPH, COL_TRANSPARENT, COL_GFXBG, { align=ALIGN_RIGHT } )
	srf_gfx.get():FillGrandient { TopLeft={20,20,20,255}, BottomLeft={20,20,20,255}, TopRight={255,100,32,255}, BottomRight={32,255,32,255} }
	srf_gfx.FrozeUnder()

	local dt = MQTTStoreGfx( name, topic, srf_Temp, srf_gfx, 
		{
			gradient = GRD_TEMPERATURE,
			forced_min = 0,
		}
	)
	table.insert( savedcols, dt )

	function self.getBelow()
		
	end

	return self
end

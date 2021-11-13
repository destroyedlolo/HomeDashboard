-- Display an hydrometry and associated gfx

function HydroArea(	
	psrf,	-- mother surface
	name, topic,
	x,y,	-- position in the mother surface
	opts
)
	if not opts then
		opts = {}
	end
	if opts.debug then
		opts.debug = opts.debug .."/HydroArea"
	end
	if not opts.gradient then
		opts.gradient = GRD_HYDRO
	end
	if not opts.sample_text then
		opts.sample_text = '100.00%'
	end
	if not opts.suffix then
		opts.suffix = '%'
	end
	if not opts.gradient then
		opts.gradient = GRD_HYDRO
	end
	if not opts.min_delta then
		opts.min_delta = 1
	end
	if opts.icon == true then
		opts.icon = DropImg
	end

	local self = MiscFigureArea( psrf, name, topic, x,y, opts )

	return self
end


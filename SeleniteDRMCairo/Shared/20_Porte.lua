-- Display gate's image

function Porte(
	psrf,			-- mother surface
	name, topic,	-- Topic to look for
	sx,sy,			-- position
	opts
)
--[[ known options :
	width, heigth : display's size
--]]
	if not opts then
		opts = {}
	end
	if not opts.width then
		opts.width = 41
	end
	if not opts.hight then
		opts.hight = 70
	end
	opts.autoscale=true

	local self = ImageSurface( psrf, sx,sy, opts.width, opts.hight, opts )

	local parent_upd = self.Update
	function self.Update( )
if opts.debug then
	print(opts.debug, name, topic, SelSharedVar.Get(name))
end
		psrf.Clear({sx,sy, opts.width, opts.hight})
		parent_upd( PorteIcons.getImg( SelSharedVar.Get(name) ) )
	end

	local dt = MQTTinput( name, topic )
	dt.TaskOnceAdd( self.Update )

	return self
end

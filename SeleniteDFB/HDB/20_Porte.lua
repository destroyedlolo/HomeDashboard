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
	if not opts.height then
		opts.height = 70
	end

	local self = ImageSurfaceBackground( psrf, sx,sy, opts.width, opts.height, opts )

	local parent_upd = self.Update
	function self.Update( )
print(SelSurface.PixelFormatConst('ARGB'), psrf:GetPixelFormat())

		parent_upd( PorteIcons.getImg( SelShared.get(name) ) )
	end

	local dt = MQTTinput( name, topic )
	dt.TaskOnceAdd( self.Update )

	return self
end

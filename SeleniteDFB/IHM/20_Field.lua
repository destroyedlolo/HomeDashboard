-- Field to display a value
ALIGN_LEFT = -1
ALIGN_CENTER = 0
ALIGN_RIGHT = 1

function Field(
	psrf,	-- mother surface
	x,y,	-- position in the mother surface
	font,	-- font to use
	align,	-- Alignment (-1 : left, 0 : center, 1 : right)
	color,	-- initial foreground color
	ctxt,	-- text to compute field's size
	szx,	-- if not null, overwrite computed size
	szy,	-- if not null, overwrite computed size
	bgcolor -- background color
)

	-- initialize
	if not szx then
		szx = font:StringWidth( ctxt )
	end
	if not szy then
		szy = font:GetHeight()
	end

	local self = SubSurface(psrf, x,y, szx, szy )
	self.get():SetFont( font )
	self.setColor( color )

	-- methods
	function self.GetHeight()
		return font:GetHeight()
	end

	function self.Clear()
		srf.get():Clear( bgcolor.get() )
	end

	function self.update( v )
		local srf = self.get()
		self.Clear()

		if align == ALIGN_LEFT then
			srf:DrawString( v, 0, 0 )
		elseif align == ALIGN_CENTER then
			srf:DrawString( v, (srf:GetWidth() - font:StringWidth(v))/2, 0 )
		else	-- right
			srf:DrawString( v, srf:GetWidth() - font:StringWidth(v), 0 )
		end

		self.refresh()
	end

	return self
end


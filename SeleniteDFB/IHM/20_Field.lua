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
	bgcolor, -- background color
	ctxt,	-- text to compute field's size
	szx		-- if not null, overwrite computed size
)
	local self = {}

	-- initialize
	if not szx then
		szx = font:StringWidth( ctxt )
	end

	local srf = SubSurface(psrf, x,y, szx, font:GetHeight() )
	srf.get():SetFont( font )
	srf.setColor( color )

	-- methods
	function self.GetHeight()
		return font:GetHeight()
	end

	function self.Clear()
		srf.get():Clear( bgcolor.get() )
	end

	function self.refresh()
		srf.refresh()
	end

	function self.update( v )
		self.Clear()

		if align == ALIGN_LEFT then
			srf.get():DrawString( v, 0, 0 )
		elseif align == ALIGN_CENTER then
		else	-- right
		end

		self.refresh()
	end

	return self
end


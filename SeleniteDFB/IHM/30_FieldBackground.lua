-- Field with a backuped background

function FieldBackground(
	psrf,	-- mother surface
	x,y,	-- position in the mother surface
	font,	-- font to use
	align,	-- Alignment (-1 : left, 0 : center, 1 : right)
	color,	-- initial foreground color
	ctxt,	-- text to compute field's size
	szx		-- if not null, overwrite computed size
)
	local self = Field( psrf, x,y, font, align, color, ctxt, szx, COL_BLACK )

	local back = self.getsrf().get():clone()

	function self.Clear()
		self.getsrf().get():restore(back)
	end

	return self
end

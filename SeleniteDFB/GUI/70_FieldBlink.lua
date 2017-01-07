-- Field that blink when a new value is received

function FieldBlink(
	psrf,	-- mother surface
	animTimer, -- Timer to use to animate the display
	x,y,	-- position in the mother surface
	font,	-- font to use
	align,	-- Alignment (-1 : left, 0 : center, 1 : right)
	color,	-- initial foreground color
	ctxt,	-- text to compute field's size
	szx,	-- if not null, overwrite computed size
	szy,	-- if not null, overwrite computed size
	bgcolor -- background color
)
	local self = Field( psrf, x,y, font, align, color, ctxt, szx, szy, bgcolor )

	return Blink( self, animTimer, color )
end

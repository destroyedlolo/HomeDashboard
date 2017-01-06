-- Field with a backuped background and border around texts

function FieldBackBorder(
	psrf,	-- mother surface
	x,y,	-- position in the mother surface
	font,	-- font to use
	align,	-- Alignment (-1 : left, 0 : center, 1 : right)
	color,	-- initial foreground color
	ctxt,	-- text to compute field's size
	szx,	-- if not null, overwrite computed size
	szy	-- if not null, overwrite computed size
)

		-- Add some room for the border
	if not szx then
		szx = font:StringWidth( ctxt ) + 4
	else
		szx = szx + 4
	end
	if not szy then
		szy = font:GetHeight() + 4
	else
		szy = szy + 4
	end

	local self = FieldBackground( psrf, x-2,y-2, font, align, color, ctxt, szx, szy )

	function self.update(v)
		-- draw borders
		self.get():SetColor( 0x00, 0x00, 0x00, 0xff)	-- Temporary set to black
		self.DrawStringOff(v, 0,0)
		self.DrawStringOff(v, 4,4)

		self.ColorApply()	-- Draw at requested color
		self.DrawStringOff(v, 2,2)

		self.refresh()
	end

	return self
end

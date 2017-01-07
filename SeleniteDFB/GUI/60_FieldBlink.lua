-- Filed that blink when a new value is received

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

	local parent_update = self.update -- update function from the parent
	local val -- value to display
	local cur_r,cur_g,cur_b,cur_a -- Current color

	local function fade()
		local r,g,b,a = color.get()

		if r < cur_r then
			cur_r = math.max( r, cur_r - 10 )
		end

		if g < cur_g then
			cur_g = math.max( g, cur_g - 10 )
		end

		if b < cur_b then
			cur_b = math.max( b, cur_b - 10 )
		end

		if a < cur_a then
			cur_a = math.max( a, cur_a - 10 )
		end

		if cur_r - r + cur_g - g + cur_b - b + cur_a - a ~= 0 then	-- Fading
			self.setColorRGB( cur_r,cur_g,cur_b,cur_a )
		else
			self.setColor( color )
		end

		parent_update( val )
	end

	function self.update( v )
		cur_r,cur_g,cur_b,cur_a = COL_WHITE.get()
		val = v
		self.setColorRGB( cur_r,cur_g,cur_b,cur_a )
		parent_update(v)

		animTimer.TaskOnceAdd( fade )
	end

	return self
end

function SubSurface(parent_surface, x,y,sx,sy )
	local self = {}

	-- fields
	local srf = parent_surface:SubSurface( x,y, sx,sy )

	local sr,sg,sb,sa -- stored color

	-- methods
	function self.get()
		return srf
	end

	function self.ColorApply()	-- apply stored color
		srf:SetColor( sr,sg,sb,sa )
	end

	function self.setColor( c )
		sr,sg,sb,sa = c.get()
		self.ColorApply()
	end

	function self.setColorRGB( ar,ag,ab,aa )	-- Set and store RGB value
		sr,sg,sb,sa = ar,ag,ab,aa
		self.ColorApply()
	end

	function self.refresh()
		srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	end

	return self
end

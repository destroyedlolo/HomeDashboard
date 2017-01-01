function SubSurface(parent_surface, x,y,sx,sy )
	local self = {}

	-- fields
	local srf = parent_surface:SubSurface( x,y, sx,sy )

	-- methods
	function self.get()
		return srf
	end

	function self.setColor( c )
		srf:SetColor( c.get() )
	end

	function self.refresh()
		srf:Flip(SelSurface.FlipFlagsConst("NONE"))
	end

	return self
end

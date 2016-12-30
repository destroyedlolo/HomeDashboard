local function f()
	self = SubSurface( psrf, 0,0, 160,psrf:GetHeight() )

	-- build graphics
	self.setColor( COL_BORDER )
	local x,y = self.get():GetWidth()-1 
	self.get():DrawLine( x, 0, x, self.get():GetHeight() )

	local ThermImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/ElectricityBG.png")
	x,y = ThermImg:GetSize()
	ThermImg:RenderTo( self.get(), { 5, 5, x,y } )
	ThermImg:Release()

	self.update()

	return self
end

LeftBar = f()

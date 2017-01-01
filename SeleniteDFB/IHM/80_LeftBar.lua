local function f()
	self = SubSurface( psrf, 0,0, 160,psrf:GetHeight() )

	-- build graphics
	self.setColor( COL_BORDER )
	local w = self.get():GetWidth()-1
	local srf = self.get()
	srf:DrawLine( w, 0, w, srf:GetHeight() )

	local ThermImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/ElectricityBG.png")
	local x,y = ThermImg:GetSize()
	ThermImg:RenderTo( srf, { 10, 15, x,y } )
	ThermImg:Release()

	local offy = 3
	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("Tension EDF :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	self.refresh()	-- refresh the background

	srf_tension = Field( srf, 10,offy, fmdigit, ALIGN_LEFT, COL_DIGIT, COL_BLACK, "888.0 V", w-13 )
srf_tension.update('124.0 V')

	return self
end

LeftBar = f()

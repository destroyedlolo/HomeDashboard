local function f()
	self = SubSurface( psrf, 0,0, 160,psrf:GetHeight() )

	-- build graphics
	local HSGRPH = 30	-- Height of small graphs

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHeight() )

	local ThermImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/ElectricityBG.png")
	local x,y = ThermImg:GetSize()
	ThermImg:RenderTo( srf, { 10, 40, x,y } )
	ThermImg:Release()

	local offy = 3
	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("Tension EDF :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	self.refresh()	-- refresh the background

	srf_tension = FieldBackground( srf, 10,offy, fmdigit, ALIGN_RIGHT, COL_DIGIT, "888.0 V", w-20 )
	offy = offy + srf_tension:GetHeight()

	srf:DrawString("Consomation :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	srf_consommation = FieldBackground( srf, 10,offy, fdigit, ALIGN_RIGHT, COL_DIGIT, "12345", w-20 )
	offy = offy + srf_consommation:GetHeight()

	x = w - (5 + fsdigit:StringWidth("12345"))
	offy = offy + HSGRPH
	srf_maxconso = FieldBackground( srf, x, offy-fsdigit:GetHeight(), fsdigit, ALIGN_RIGHT, COL_DIGIT, "12345")

	srf:DrawString("Production :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	srf_production = FieldBackground( srf, 10,offy, fdigit, ALIGN_RIGHT, COL_DIGIT, "12345", w-20 )
	offy = offy + srf_production:GetHeight()

	x = w - (5 + fsdigit:StringWidth("12345"))
	offy = offy + HSGRPH
	srf_maxprod = FieldBackground( srf, x, offy-fsdigit:GetHeight(), fsdigit, ALIGN_RIGHT, COL_DIGIT, "12345")

	self.refresh()

srf_tension.update('124.0 V')
srf_consommation.update('12345')
srf_maxconso.update('12345')
srf_production.update('12345')
srf_maxprod.update('12345')

	return self
end

LeftBar = f()

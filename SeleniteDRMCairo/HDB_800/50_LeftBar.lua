local function f()
	self = Surface( psrf, 0,0,LBw, psrf:GetHight() )

	-- build graphics

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHight() )

	local offy = 3 + fonts.title1.size
	self.setColor( COL_TITLE )
	self.setFont( fonts.title1 )
	srf:DrawStringTop("Tension EDF :", 5, offy )

	offy = offy + self.get():GetFontExtents()

	local srf_tension = FieldBlink( self, animTimer, 30, offy, fonts.mdigit, COL_DIGIT, {
		ndecimal=0,
		align = ALIGN_RIGHT,
		sample_text = "888"
	})
	self.setFont( fonts.mdigit )
	srf:DrawStringTop(" V", srf_tension.getAfter())

	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { condition=condition_network } )

	-- Drawing finished and alway visible
	self.Visibility(true)

	return self
end

LeftBar = f()


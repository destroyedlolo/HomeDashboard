-- Percentage gauge
function Gauge(
	psrf,	-- mother surface
	sx,sy,	-- position in the mother surface
	sw,sh,	-- its size
	bgcolor -- background color
)
	local self = SubSurface(psrf, sx,sy, sw,sh )

	local degImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/Degrade.png")
	local degSrf = degImg:toSurface()
	degImg:destroy()

	function self.Clear()
		self.get():Clear( bgcolor.get() )
	end

	function self.Draw( v )
		self.Clear()

		self.get():SetClipS(0,0, self.get():GetWidth()*v/100, self.get():GetHeight())
		self.get():StretchBlit(degSrf)

		self.refresh()
	end

	return self
end

-- Display Rez-de-chaussée figures

local function rdc()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h, 
		{
			keepcontent = true
		}
	)

	local backgnd,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/RDC.png")
	if not backgnd then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear(
		clipped -- Clipping region
	)

		-- Restrict drawing area
		if clipped then	-- Offset this surface
			self.get():SaveContext()
			self.get():SetClipS( unpack(clipped) )
		end
	
		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.setColor( COL_TITLE )
		self.setFont( fonts.title )
		self.get():DrawStringTop("Rez-de-chaussée :", 5,0 )
		self.get():Blit(backgnd, 135,135)

		if clipped then
			self.get():RestoreContext()
		end
	end
	self.Clear()

	local TBureau = TempArea( self, "TBureau", "maison/Temperature/Bureau", 231,397, { shadow=true, transparency=true })
	local TSalon = TempArea( self, "TSalon", "maison/Temperature/Salon", 412,378, { shadow=true, transparency=true })

		-- No transparency needed as on black background
	local TDehors = TempArea( self, "TDehors", "maison/Temperature/Dehors", 850,30)

	self.Visibility(false)
	return self
end

RDC = rdc()

table.insert( winlist, RDC )


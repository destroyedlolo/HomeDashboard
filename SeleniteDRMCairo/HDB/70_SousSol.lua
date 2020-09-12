-- Display basement figures

local function soussol()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h, 
		{
			keepcontent = true
		}
	)

	local backgnd,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/SS.png")
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
		self.get():DrawStringTop("Sous-Sol :", 5,0 )
		self.get():Blit(backgnd, 150,52)

		if clipped then
			self.get():RestoreContext()
		end
	end
	self.Clear()

	TempArea( self, "TSSPorte", "maison/Temperature/GarageP", 260,460, { border=COL_BORDER, shadow=true, transparency=true })

	TempArea( self, "TSS", "maison/Temperature/Garage", 680,290, { border=COL_BORDER, shadow=true, transparency=true })

	TempArea( self, "TCVin", "maison/Temperature/Cave Vin", 590, 75, { border=COL_BORDER, shadow=true, transparency=true })

	TempArea( self, "TCongelo", "maison/Temperature/Congelateur", 700, 170,
		{
			gradient = Gradient( {
				[-19] = COL_DIGIT,
				[-16] = COL_GREEN,
				[-12] = COL_ORANGE,
				[-10] = COL_RED
			} ),
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)

	self.Visibility(false)
	return self
end

SousSol = soussol()

table.insert( winlist, SousSol )

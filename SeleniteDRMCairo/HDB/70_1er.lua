-- Display Rez-de-chaussée figures

local function etage()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h, 
		{
			keepcontent = true
		}
	)

	local backgnd,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/1er.png")
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
		self.get():DrawStringTop("1er étage :", 5,0 )
		self.get():Blit(backgnd, 150,52)

		if clipped then
			self.get():RestoreContext()
		end
	end
	self.Clear()

	local TGrenierNord = TempArea( self, "TGrenierNord", "maison/Temperature/Grenier Nord", 223,361, { border=COL_BORDER, shadow=true, transparency=true })
	local TChJoris = TempArea( self,
		"TChJoris", "maison/Temperature/Chambre Joris", 
		405,380, 
		{
			TempTracking=MAJORDOME .. "/SurveillanceChJoris/status",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)
	local TChOceane = TempArea( self,
		"TChOceane", "maison/Temperature/Chambre Oceane",
		565,320,
		{
			TempTracking=MAJORDOME .. "/SurveillanceChOceane/status",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)
	local TChParent = TempArea( self,
		"TChParent", "maison/Temperature/Chambre Parents",
		427,136,
		{
			TempTracking=MAJORDOME .. "/SurveillanceChParents/status",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)
	local TGrenierSud = TempArea( self, "TGrenierSud", "maison/Temperature/Grenier Sud", 678,211, { border=COL_BORDER, shadow=true, transparency=true })

		-- No transparency needed as on black background
	local TComble = TempArea( self, "TComble", "maison/Temperature/Comble", 896,38)

	self.Visibility(false)
	return self
end

Etage = etage()

table.insert( winlist, Etage )


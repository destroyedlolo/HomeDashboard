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

	TempArea( self, "TGrenierNord", "maison/Temperature/Grenier Nord", 223,361, { border=COL_BORDER, shadow=true, transparency=true })

	Porte( self, 'PorteGN', 'maison/IO/Porte_GNord', 300, 288 )

	TempArea( self,
		"TChJoris", "maison/Temperature/Chambre Joris", 
		405,380, 
		{
			TempTracking=MAJORDOME .. "/SurveillanceChJoris/status",
			ModeTopic=MAJORDOME .. "/Mode/Joris",
			HLeverTopic=MAJORDOME .. "/HLever/Joris",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)

	TempArea( self,
		"TChOceane", "maison/Temperature/Chambre Oceane",
		565,320,
		{
-- debug="TCO",
			TempTracking=MAJORDOME .. "/SurveillanceChOceane/status",
			ModeTopic=MAJORDOME .. "/Mode/Oceane",
			HLeverTopic=MAJORDOME .. "/HLever/Oceane",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)

	local TChAmis = TempArea( self,
		"TAmis", "maison/Temperature/Chambre Amis",
		427,136,
		{
			TempTracking=MAJORDOME .. "/SurveillanceChAmis/status",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)

	TempArea( self, "TGrenierSud", "maison/Temperature/Grenier Sud", 678,211, { border=COL_BORDER, shadow=true, transparency=true })

	Porte( self, 'PorteGS', 'maison/IO/Porte_GSud', 607,187 )

		-- No transparency needed as on black background
	TempArea( self, "TComble", "maison/Temperature/Comble", 896,38)

	self.Visibility(false)
	return self
end

Etage = etage()

table.insert( winlist, Etage )


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
	local Engrenages,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Engrenages.png")
	if not Engrenages then
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
		self.get():Blit(backgnd, 25,85)
		self.get():Blit(Engrenages, WINSIZE.w - Engrenages:GetWidth(), WINSIZE.h - Engrenages:GetHight())

		if clipped then
			self.get():RestoreContext()
		end
	end
	self.Clear()

	TempArea( self,
		"TBureau", "maison/Temperature/Bureau",
		121,347,
		{
			TempTracking=MAJORDOME .. "/SurveillanceBureau/status",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)

	TempArea( self,
		"TChParent", "maison/Temperature/Chambre Parents",
		120,163,
		{
			TempTracking=MAJORDOME .. "/SurveillanceChParents/status",
			ModeTopic=MAJORDOME .. "/Mode/Parents",
			HLeverTopic=MAJORDOME .. "/HLever",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)

	TempArea( self,
		"TSalon", "maison/Temperature/Salon",
		302,328,
		{
			TempTracking=MAJORDOME .. "/SurveillanceSalon/status",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)

	local srf_JourFerie = FieldBlink( self, animTimer, 820, 620, fonts.digit, COL_DIGIT, {
		align = ALIGN_CENTER, 
		sample_text = "Victoire des allies",
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
	})
	MQTTDisplay( 'JourFerieSN', MAJORDOME .. '/JourFerieSuivant/Nom', srf_JourFerie, {
--		debug = 'JourFerieSN'
	})

		-- No transparency needed as on black background
--	local TDehors = TempArea( self, "TDehors", "maison/Temperature/Dehors", 850,30)

	Porte( self, 'PorteEscalier', 'maison/IO/Porte_Escalier', 471, 190 )

	self.Visibility(false)
	return self
end

RDC = rdc()

table.insert( winlist, RDC )


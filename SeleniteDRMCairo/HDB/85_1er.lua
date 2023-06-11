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
		self.get():Blit(backgnd, 70,52)

		if clipped then
			self.get():RestoreContext()
		end
	end
	self.Clear()

	TempArea( self, "TGrenierNord", "maison/Temperature/Grenier Nord", 103,312, { border=COL_BORDER, shadow=true, transparency=true })

	Porte( self, 'PorteGN', 'maison/IO/Porte_GNord', 195, 217 )

	TempArea( self,
		"TChJoris", "maison/Temperature/Chambre Joris", 
		287,333, 
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
		458,285,
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
		319,95,
		{
			TempTracking=MAJORDOME .. "/SurveillanceChAmis/status",
			border=COL_BORDER,
			shadow=true,
			transparency=true
		}
	)

	TempArea( self, "TGrenierSud", "maison/Temperature/Grenier Sud", 557,185, { border=COL_BORDER, shadow=true, transparency=true })

	Porte( self, 'PorteGS', 'maison/IO/Porte_GSud', 502,158 )

		-- No transparency needed as on black background
	TempArea( self, "TComble", "maison/Temperature/Comble", 816,38)


		-- Pool consumption
	local srf_consopiscine = Field( self, 1000, 435, fonts.seg, COL_DIGIT, {
		timeout = 10,
		align = ALIGN_RIGHT, 
		sample_text = "12345",
		ownsurface=true,
		bgcolor = COL_TRANSPARENT,
		transparency = true,
		gradient = GRD_POMPEPISCINE
	} )
	self.setFont( fonts.mdigit )
	self.get():DrawStringTop(" VA", srf_consopiscine.getAfter())

-- 550,480, 610, 100
	local srf_trndconsopiscine = GfxArea( self, 470,500, 690, 100, COL_ORANGE, COL_BLACK,{
		align=ALIGN_RIGHT,
		gradient = GRD_POMPEPISCINE,
--[[
		heverylines={ {1000, COL_DARKGREY} },
		transparency = true,
		ownsurface = true,
--]]
	} )

	local consopiscine = MQTTStoreGfx( 'consopiscine', 'TeleInfo/PompePiscine/values/PAPP', srf_consopiscine, srf_trndconsopiscine, 
		{
--[[
			smax = srf_maxconso,
			force_max_refresh = true,
			smin = srf_minconso,
			force_min_refresh = true,
			forced_min = 0,
			condition=condition_network
--]]
		}
	)

	self.Visibility(false)
	return self
end

Etage = etage()

table.insert( winlist, Etage )


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
		self.get():Blit(backgnd, 5,22)

		if clipped then
			self.get():RestoreContext()
		end
	end
	self.Clear()

	TempArea( self, "TSSPorte", "maison/Temperature/GarageP", 155,460, { border=COL_BORDER, shadow=true, transparency=true })
	Porte( self, 'PorteGarage', 'maison/IO/Porte_Garage', 128, 550 )

	TempArea( self, "TSS", "maison/Temperature/Garage", 565,312, { border=COL_BORDER, shadow=true, transparency=true })
	Porte( self, 'PorteCave', 'maison/IO/Porte_Cave', 478, 257 )

	TempArea( self, "TBuanderie", "maison/Temperature/Buanderie", 307,170, { border=COL_BORDER, shadow=true, transparency=true })

	TempArea( self, "TCVin", "maison/Temperature/Cave Vin", 482, 65, { border=COL_BORDER, shadow=true, transparency=true })

	TempArea( self, "TCongelo", "maison/Temperature/Congelateur", 546, 168,
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

	---
	--Electricity
	---
	local w = WINSIZE.w - 775

	MQTTCounterStatGfx( self,
		'Stat mensuelle', 'Domestik/Electricite/Mensuel', 
		760,30 , WINSIZE.w - 775,175, {
			bordercolor = COL_GREY ,
			consumption_border = COL_ORANGED,
			xproduction_border = COL_GREEND,
			maxyears = 5,
			fadeyears = 5,
			barrespace = 2,
			yearXoffset = 4,
			production_offset = 2
		} 
	)

	w = w-10
	local srf_ctrndconso = GfxArea( self, 760, 210, w/2, 85, COL_TRANSPARENT, COL_GFXBG,{
-- debug="conso",
		gradient = GRD_CONSOMMATION,
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT
	} )

	local srf_maxconso = FieldBlink( srf_ctrndconso, animTimer, 2, 0, fonts.xsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = '12345',
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_CONSOMMATION
	} )

	local srf_minconso = FieldBlink( srf_ctrndconso, animTimer, 2, 85-fonts.xsdigit.size, fonts.xsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = '12345',
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_CONSOMMATION
	} )

	local conso2 = MQTTStoreGfx( 'consommation2', 'TeleInfo/Consommation/values/PAPP', nil, srf_ctrndconso, 
		{
--			forced_min = 0,
			smax = srf_maxconso,
			smin = srf_minconso,
			force_max_refresh = true,
			force_min_refresh = true,
			group = 18*60*60 / srf_ctrndconso.get():GetWidth()	-- 6h retention
		}
	)
	table.insert( savedcols, conso2 )

	local srf_ctrndprod = GfxArea( self, 770 + w/2, 210, w/2, 85, COL_TRANSPARENT, COL_GFXBG,{
		gradient = GRD_PRODUCTION,
		heverylines={ {1000, COL_DARKGREY} },
		vlinesH=COL_DARKGREY,
		vlinesD=COL_GREY,
		align=ALIGN_RIGHT 
	} )

	local srf_maxprod = FieldBlink( srf_ctrndprod, animTimer, 2, 0, fonts.xsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = '12345',
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_CONSOMMATION
	} )

	local srf_minprod = FieldBlink( srf_ctrndprod, animTimer, 2, 85-fonts.xsdigit.size, fonts.xsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = '12345',
		bgcolor = COL_TRANSPARENT,
		included = true,
		gradient = GRD_CONSOMMATION
	} )


	local prod2 = MQTTStoreGfx( 'production2', 'TeleInfo/Production/values/PAPP', nil, srf_ctrndprod, 
		{
			forced_min = 0,
			smax = srf_maxprod,
			smin = srf_minprod,
			force_max_refresh = true,
			force_min_refresh = true,
			group = 18*60*60 / srf_ctrndprod.get():GetWidth()	-- 6h retention
		}
	)
	table.insert( savedcols, prod2 )

	SelLog.log("Consummation / Production grouped by ".. 6*60*60 / srf_ctrndconso.get():GetWidth())

	---

	local srf_ConsoJ = Field( self, 790, 305, fonts.mseg, COL_DIGIT, {
		timeout = 300,
		align = ALIGN_RIGHT,
		sample_text = '88888'
	} )

	local function updConsoJ()
		srf_ConsoJ.update( ConsoJ.get() )
	end

	ConsoJ.TaskOnceAdd( updConsoJ )

	---

	local srf_ProdJ = Field( self, 800 + w/2, 305, fonts.mseg, COL_DIGIT, {
--		timeout = 300,
		align = ALIGN_RIGHT,
		sample_text = '88888'
	} )

	local function updProdJ()
		srf_ProdJ.update( ProdJ.get() )
	end

	ProdJ.TaskOnceAdd( updProdJ )

	---

	self.Visibility(false)
	return self
end

SousSol = soussol()

table.insert( winlist, SousSol )

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
		self.get():Blit(backgnd, 20,52)

		if clipped then
			self.get():RestoreContext()
		end
	end
	self.Clear()

	TempArea( self, "TSSPorte", "maison/Temperature/GarageP", 130,460, { border=COL_BORDER, shadow=true, transparency=true })

	TempArea( self, "TSS", "maison/Temperature/Garage", 550,290, { border=COL_BORDER, shadow=true, transparency=true })

	TempArea( self, "TCVin", "maison/Temperature/Cave Vin", 460, 75, { border=COL_BORDER, shadow=true, transparency=true })

	TempArea( self, "TCongelo", "maison/Temperature/Congelateur", 570, 170,
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
			barrespace = 0,
			yearXoffset = 6,
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

	local conso2 = MQTTStoreGfx( 'consommation2', 'TeleInfo/Consommation/values/PAPP', nil, srf_ctrndconso, 
		{
			forced_min = 0,
			smax = maxTConso,
			force_max_refresh = true,
			group = 6*60*60 / srf_ctrndconso.get():GetWidth()	-- 6h retention
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

	local prod2 = MQTTStoreGfx( 'production2', 'TeleInfo/Production/values/PAPP', nil, srf_ctrndprod, 
		{
			smax = maxTProd,
			force_max_refresh = true,
			forced_min = 0,
			group = 6*60*60 / srf_ctrndprod.get():GetWidth()	-- 6h retention
		}
	)
	table.insert( savedcols, prod2 )

	SelLog.log("*I* Consummation / Production grouped by ".. 6*60*60 / srf_ctrndconso.get():GetWidth())

	---

	self.Visibility(false)
	return self
end

SousSol = soussol()

table.insert( winlist, SousSol )

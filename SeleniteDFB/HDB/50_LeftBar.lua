local function f()
	self = SubSurface( psrf, 0,0, LBw, psrf:GetHight() )

	-- build graphics

	local w = self.get():GetWidth()-1
	local srf = self.get()
	self.setColor( COL_BORDER )
	srf:DrawLine( w, 0, w, srf:GetHight() )

--[[
	local ElecBgImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/ElectricityBG.png")
	local x,y = ElecBgImg:GetSize()
	ElecBgImg:RenderTo( srf, { 20, 40, x,y } )
	ElecBgImg:Release()
--]]
	local offy = 3
	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("Tension EDF :", 5, offy )
	offy = offy + ftitle1:GetHeight()
	self.refresh()	-- refresh the background to let subSurface to backup the background if needed

	local srf_tension = FieldBackgroundBlink( srf, animTimer, 10,offy, fmdigit, COL_DIGIT, {
		ndecimal=0,
		align = ALIGN_RIGHT,
		sample_text = "888", 
		width = w-20 - fmdigit:StringWidth(" V")
	})
	srf:SetFont( fmdigit )
	srf:DrawString(" V", srf_tension.get():GetAfter() )
	offy = offy + srf_tension.getHight()
	local tension = MQTTDisplay( 'tension', 'onduleur/input.voltage', srf_tension, { condition=condition_network } )

	srf:SetFont( ftitle1 )
	srf:DrawString("Consomation :", 5, offy )
	offy = offy + ftitle1:GetHeight()

	local srf_consommation = Field( srf, 10,offy, fdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "12345", 
		width = w-20 - fmdigit:StringWidth(" VA"),
		gradient = Gradient(
			{
				[500] = COL_DIGIT,
				[1500] = COL_ORANGE,
				[4500] = COL_RED
			}
		)
	} )
	srf:SetFont( fdigit )
	srf:DrawString(" VA", srf_consommation.get():GetAfter() )
	offy = offy + srf_consommation.getHight()

	local x = w - (5 + fsdigit:StringWidth("12345"))

	local srf_trndconso = GfxArea( srf, 0, offy, x-5, HSGRPH, COL_TRANSPARENT, COL_GFXBG,{
		heverylines={ {1000, COL_DARKGREY} },
		align=ALIGN_RIGHT 
	} )
	srf_trndconso.get():FillGrandient { TopLeft={48,48,48,255}, BottomLeft={48,48,48,255}, TopRight={255,32,32,255}, BottomRight={32,255,32,255} }
	srf_trndconso.FrozeUnder()

	local srf_maxconso = FieldBackgroundBlink( srf, animTimer, x, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "12345"
	} )
	offy = offy + HSGRPH

	local consomation = MQTTStoreGfx( 'consomation', 'TeleInfo/Consommation/values/PAPP', srf_consommation, srf_trndconso, 
		{
			smax = srf_maxconso,
			forced_min = 0,
			condition=condition_network
		}
	)


	srf:SetFont( ftitle1 )
	srf:DrawString("Production :", 5, offy )
	offy = offy + ftitle1:GetHeight()

	local srf_production = Field( srf, 10,offy, fdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "12345", 
		width = w-20 - fmdigit:StringWidth(" VA") 
	} )
	srf:SetFont( fdigit )
	srf:DrawString(" VA", srf_production.get():GetAfter() )
	offy = offy + srf_production.getHight()

-- already calculated
-- x = w - (5 + fsdigit:StringWidth("12345"))

	local srf_trndprod = GfxArea( srf, 0, offy, x-5, HSGRPH, COL_TRANSPARENT, COL_GFXBG, {
		heverylines={ {250, COL_DARKGREY, 1250}, { 1000, COL_GREY } },
		align=ALIGN_RIGHT
	} )
	srf_trndprod.get():FillGrandient { TopLeft={40,40,40,255}, BottomLeft={40,40,40,255}, TopRight={32,255,32,255}, BottomRight={32,255,255,255} }
	srf_trndprod.FrozeUnder()

	local srf_maxprod = FieldBlink( srf, animTimer, x, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "12345"
	} )
	local production = MQTTStoreGfx( 'production', 'TeleInfo/Production/values/PAPP', 
		srf_production, srf_trndprod,
		{ smax = srf_maxprod, forced_min = 0, condition=condition_network }
	)
	offy = offy + HSGRPH + 3

	local srf_onduleur = FieldBlink( srf, animTimer, 0, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT, 
		sample_text = "888.8 W",
		suffix = ' W'
	} )
	x = srf_onduleur.get():GetWidth()

	local srf_gaugeOnduleur = GaugeHPercentBg( srf, x+4, offy+8, w-x-8, srf_onduleur.get():GetHight()-16, COL_GFXBG, COL_BORDER )
	local onduleur = UPSdata('UPS', 'onduleur/ups.load', 'onduleur/ups.realpower.nominal', srf_onduleur, srf_gaugeOnduleur, { condition=condition_network })
	offy = offy + srf_onduleur.get():GetHight() + 2


--
-- Key temperatures
--
-- A revoir quand la météo et les temperatures seront en place
--

	offy = offy + ftitle1:GetHeight()

	local ThermImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/Thermometre.png") 
	assert(ThermImg, "Can't load image")

	ThermImg:RenderTo( srf, { 5, offy, 25,90 } )
	ThermImg:Release()

	local srf_TSalon = FieldBlink( srf, animTimer, w-8 - fdigit:StringWidth("°C"), offy, fdigit, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8",
		gradient = GRD_TEMPERATURE
	})
	srf:SetFont( ftitle1 )
	srf:DrawString("Salon :", srf_TSalon.get():GetPosition(), offy - ftitle1:GetHeight() )
	local srf_Thermometre = GaugeRange( srf, 14,325, 6, 63, COL_RED, COL_WHITE, 5,35, { vertical = true } )
	local TSalon = MQTTDisplay( 'TSalon', 'maison/Temperature/Salon', srf_TSalon )
	offy = offy + srf_TSalon.getHight()

	local function updthermo()
		srf_Thermometre.Draw( TSalon.get() )
	end
	TSalon.TaskOnceAdd( updthermo )

	offy = offy + ftitle1:GetHeight()
	self.srf_TDehors = FieldBlink( srf, animTimer, w-8 - fdigit:StringWidth("°C"), offy, fdigit, COL_DIGIT, {
		align = ALIGN_FRIGHT,
		sample_text = "-88.8",
		{ gradient = GRD_TEMPERATURE }
	})
	srf:DrawString("Extérieur :", self.srf_TDehors.get():GetPosition(), offy - ftitle1:GetHeight() )
--	local TDehors = MQTTDisplay( 'TDehors', 'maison/Temperature/Dehors', srf_TDehors )

	srf:SetFont( fdigit )
	srf:DrawString("°C", srf_TSalon.get():GetAfter() )
	srf:DrawString("°C", self.srf_TDehors.get():GetAfter() )
	offy = offy + self.srf_TDehors.getHight()
--[[
	self.setColor( COL_BORDER )
	srf:DrawLine( 0, offy, w, offy )
]]

	offy = offy+2
	local srf_dATM = FieldBlink( srf, animTimer, (w-fsdigit:StringWidth("0000"))/2 , offy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		sample_text = "0000"
	} )
	offy = offy + srf_dATM.getHight()

	local srf_uATM = FieldBlink( srf, animTimer, (w-fsdigit:StringWidth("0000"))/2 , offy, fsdigit, COL_DIGIT, {
		align = ALIGN_CENTER,
		sample_text = "0000"
	} )

	x,y = srf_dATM.get():GetPosition()
	local srf_dnGfx = ArcGaugePercent(srf, 0, y, x-4, srf_dATM.getHight() + srf_uATM.getHight(), 10, 2, { emptycolor=COL_GFXBG })

	x = x + srf_dATM.get():GetWidth() + 4
	local srf_upGfx = ArcGaugePercent(srf, x, y, w - x, srf_dATM.getHight() + srf_uATM.getHight(), 10, 1, { emptycolor=COL_GFXBG })

	local wdfreebox, _ = SelTimer.create { when=40, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), ifunc= function ()
			Notification.setColor( COL_RED )
			Notification.Log( "Freebox muette")
			Notification.setColor( COL_WHITE )
			condition_freebox.report_issue()
		end
	}
	local dWAN = FAIdata( 'dWAN', 'Freebox/DownloadATM', 'Freebox/UploadTV', 'Freebox/DownloadWAN', srf_dATM, srf_dnGfx, { watchdog=wdfreebox, condition=condition_freebox } )
	local uWAN = FAIdata( 'uWAN', 'Freebox/UploadATM', 'Freebox/DownloadTV', 'Freebox/UploadWAN', srf_uATM, srf_upGfx )
	table.insert( additionnalevents, wdfreebox )

	self.refresh()

	return self
end

LeftBar = f()

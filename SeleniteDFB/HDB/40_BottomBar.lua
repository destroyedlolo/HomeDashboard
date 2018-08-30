local function f()
	local self = SubSurface( psrf, LBw, psrf:GetHight()-BBh, psrf:GetWidth() - LBw, BBh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()
	local offx=0,offy

	local lvdonotif = ImageFiltreSurface( srf, offx, 24, SELENE_SCRIPT_DIR .. "/Images/Mail.png" )
	condition_lvdo = Condition( lvdonotif, 0 )
	local poolnotif = ImageFiltreSurface( srf, offx, 0, SELENE_SCRIPT_DIR .. "/Images/Piscine.png" )
	condition_pool = Condition( poolnotif, 0, {
		ok_color = COL_DARKGREEN,
		issue_color = COL_DARKRED
	} )
	offx = offx + 24

	local network = ImageFiltreSurface( srf, offx,24, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25, { issue_color=COL_RED } )
	table.insert( additionnalevents, condition_network.getTimer() )

	local freeboxicn = ImageFiltreSurface( srf, offx,0, SELENE_SCRIPT_DIR .. "/Images/FreeboxL.png" )
	condition_freebox = Condition(freeboxicn, .5, { autorecover=true, issue_color=COL_RED } )
	table.insert( additionnalevents, condition_freebox.getTimer() )
	offx = offx + 24

	local WiFi = ImageFiltreSurface( srf, offx,24, SELENE_SCRIPT_DIR .. "/Images/WiFi.png" )
	condition_WiFi = Condition(WiFi, .5, { autorecover=true, issue_color=COL_RED } )
	table.insert( additionnalevents, condition_WiFi.getTimer() )

	local wdWiFi, _ = SelTimer.Create { when=150, clockid=SelTimer.ClockModeConst("CLOCK_MONOTONIC"), ifunc= function ()
			Notification.setColor( COL_RED )
			Notification.Log( "Répéteur WiFi muet")
			Notification.setColor( COL_WHITE )
			condition_WiFi.report_issue()
		end
	}
	table.insert( additionnalevents, wdWiFi )
	local WiFiNoStations = MQTTinput('WiFiNoStations', 'ESPRouter_Domo/NoStations', nil, { condition=condition_WiFi, watchdog=wdWiFi } )

	local barriere = ImageFiltreSurface( srf, offx,0, SELENE_SCRIPT_DIR .. "/Images/BarrierePoule.png" )
	condition_BarrierePoule = Condition( barriere, 0, {issue_color=COL_RED } )
	offx = offx + 24

	Notification = NotificationArea( srf, offx, 0, 200, sh, fstxt, COL_DARKGREEN, { bgcolor=COL_GFXBG } )
	local log = MQTTLog('messages', 'messages', Notification, { udata=-1 } )
	log.RegisterTopic('messages', 'messages/Erreur', { udata=3 } )
	offx = offx + 200

	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("bPI :", offx, 0)
	offy = math.max( ftitle1:GetHeight(), fsdigit:GetHeight() )

	local srf_trndbPI = GfxArea( srf,
		offx, offy, 
		ftitle1:StringWidth("bPI :") + fsdigit:StringWidth("15.23 - 88.88°C"), srf:GetHight()-offy, 
		COL_TRANSPARENT, COL_BLACK,
		{ 
			align=ALIGN_RIGHT,
			stretch = 1,
			heverylines={ {0.25, COL_DARKGREY, 2}, { 1, COL_GREY, 10 } }
		}
	)
	srf_trndbPI.get():FillGrandient { TopLeft={20,20,20,255}, BottomLeft={20,20,20,255}, TopRight={255,200,32,255}, BottomRight={32,255,32,255} }
	srf_trndbPI.FrozeUnder()
	local cloadbPI = FieldBlink( srf, animTimer, offx + ftitle1:StringWidth("bPI :"), 0, fsdigit, COL_DIGIT, {
		timeout = 60,
		align = ALIGN_RIGHT,
		sample_text = "15.23",
		gradient = Gradient(
			{
				[.1] = COL_GREEN,
				[1] = COL_ORANGE,
				[2] = COL_RED
			}
		),
	} )

	local mloadbPI = FieldBlink( srf, animTimer, offx, offy, fstxt, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "15.23",
		ndecimal = 2,
		gradient = Gradient(
			{
				[.1] = COL_GREEN,
				[1] = COL_ORANGE,
				[2] = COL_RED
			}
		),
	} )

	local loadbPI = MQTTStoreGfx( 'bPI', 'Machines/bPI/Load/1', cloadbPI, srf_trndbPI, 
		{
			smax = mloadbPI,
			forced_min = 0,
			condition=condition_network,
			force_max_refresh = 1
		}
	)
	table.insert( savedcols, loadbPI )

	offx, offy = cloadbPI.getAfter()
	srf:DrawString(" -", offx, offy )
	offx = offx + fsdigit:StringWidth(" - ")

	local tbPI = FieldBlink( srf, animTimer, offx, 0, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "88.8°C",
		suffix = '°C',
		gradient = Gradient(
			{
				[20] = COL_GREEN,
				[30] = COL_ORANGE,
				[40] = COL_RED
			}
		),
	} )

	MQTTDisplay('temp bPI', 'Machines/bPI/PMUTemp', tbPI )

	offx, offy = srf_trndbPI.getAfter()
	Saison( srf, 'Saison', 'Majordome/Saison', offx, 0 )

	self.refresh()
	return self
end

BottomBar = f()

local function f()
	local self = SubSurface( psrf, LBw, psrf:GetHight()-BBh, psrf:GetWidth() - LBw, BBh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()
	local offx=24,offy

	local network = ImageFiltreSurface( srf, 0,24, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25 )
	table.insert( additionnalevents, condition_network.getTimer() )

	Notification = NotificationArea( srf, 24, 0, 200, sh, fstxt, COL_LIGHTGREY, { bgcolor=COL_GFXBG } )
	MQTTLog(nil, 'messages', Notification)
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

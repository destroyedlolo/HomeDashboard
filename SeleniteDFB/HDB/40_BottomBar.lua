local function f()
	local self = SubSurface( psrf, LBw, psrf:GetHeight()-BBh, psrf:GetWidth() - LBw, BBh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()
	local offx=24,offy

	local network = ImageFiltreSurface( srf, 0,24, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25 )
	table.insert( condlisttmr, condition_network.getTimer() )

	Notification = NotificationArea( srf, 24, 0, 200, sh, fstxt, COL_LIGHTGREY, { bgcolor=COL_GFXBG } )
	offx = offx + 200

	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("bPI :", offx, 0)
	offy = math.max( ftitle1:GetHeight(), fsdigit:GetHeight() )

	local srf_trndbPI = GfxArea( srf,
		offx, offy, 
		100, srf:GetHeight()-offy, 
		COL_TRANSPARENT, COL_BLACK,
		{ 
			align=ALIGN_RIGHT,
			stretch = 1,
--			vevrylines={ {1, COL_DARKGREY} }
		}
	)
	srf_trndbPI.get():FillGrandient { TopLeft={20,20,20,255}, BottomLeft={20,20,20,255}, TopRight={255,200,32,255}, BottomRight={32,255,32,255} }
	srf_trndbPI.FrozeUnder()
	local cloadbPI = FieldBlink( srf, animTimer, offx + ftitle1:StringWidth("bPI :"), 0, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "5.23",
		gradient = Gradient(
			{
				[.1] = COL_GREEN,
				[1] = COL_ORANGE,
				[2] = COL_RED
			}
		),
	} )
print( offx + ftitle1:StringWidth("bPI :"), 0 )

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

	offx, offy = cloadbPI.get():GetAfter()
print(offx, 0)
	srf:DrawString(" -", offx, 0 )
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

	self.refresh()
	return self
end

BottomBar = f()

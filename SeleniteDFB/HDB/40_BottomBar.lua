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
	local loadbPI = FieldBlink( srf, animTimer, offx + ftitle1:StringWidth("bPI :"), 0, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "5.23"
	} )

	local mloadbPI = FieldBlink( srf, animTimer, offx, offy, fstxt, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "15.23",
		ndecimal = 2,
	} )

	local consomation = MQTTStoreGfx( 'bPI', 'Load/bPI/1', loadbPI, srf_trndbPI, 
		{
			smax = mloadbPI,
			gradient = Gradient(
				{
					[.1] = COL_GREEN,
					[1] = COL_ORANGE,
					[2] = COL_RED
				}
			),
			forced_min = 0,
			condition=condition_network,
			force_max_refresh = 1
		}
	)

	self.refresh()
	return self
end

BottomBar = f()

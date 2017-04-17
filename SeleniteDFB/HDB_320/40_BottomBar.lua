-- Notification area at the bottom of the screen

local function f()
	local sw = psrf:GetWidth() - LBw
	local sh = fstxt:GetHeight()*NotLine

	local self = SubSurface( psrf, LBw, psrf:GetHeight()-sh, sw, sh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()
	local offx,offy

	local network = ImageFiltreSurface( srf, 0,24, SELENE_SCRIPT_DIR .. "/Images/Network.png" )
	condition_network = Condition( network, .25 )
	table.insert( condlisttmr, condition_network.getTimer() )

	offx = 24
	Notification = NotificationArea( srf, 24, 0, 100, sh, fstxt, COL_LIGHTGREY, { bgcolor=COL_GFXBG } )
	offx = offx + 100

	self.setColor( COL_TITLE )
	srf:SetFont( ftitle1 )
	srf:DrawString("bPI :", offx, 0)
	offy = ftitle1:GetHeight()
	local srf_trndbPI = GfxArea( srf,
		offx, offy, 
		srf:GetWidth() - offx, srf:GetHeight()-offy, 
		COL_TRANSPARENT, COL_GFXBG, { align=ALIGN_RIGHT, stretch = 1 }
	)
	srf_trndbPI.get():FillGrandient { TopLeft={40,40,40,255}, BottomLeft={40,40,40,255}, TopRight={255,200,32,255}, BottomRight={32,255,32,255} }
	srf_trndbPI.FrozeUnder()
	local loadbPI = FieldBlink( srf, animTimer, offx + ftitle1:StringWidth("bPI :"), 0, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "5.23"
	} )

	local mloadbPI = FieldBlink( srf, animTimer, offx, offy, fsdigit, COL_DIGIT, {
		align = ALIGN_RIGHT,
		sample_text = "5.23",
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

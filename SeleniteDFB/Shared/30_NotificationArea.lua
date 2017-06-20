-- Notification area at the bottom of the screen

function NotificationArea(
	psrf,		-- Parent surface
	x,y, w,h,	-- Geometry
	font, tcolor,
	opts
)
	local self = TextArea( psrf, x,y, w,h, font, tcolor, opts )

	function self.Log( msg )
		self.SmartCR()
		self.DrawString( msg )
	end

	function self.Display( txt, udt )
		self.Log(txt)
	end

	return self
end

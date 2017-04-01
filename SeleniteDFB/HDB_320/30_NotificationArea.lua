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

	local function rcvLog()	-- Receiving a log
		self.Log( SelShared.get('Log') )
	end

	tlog = MQTTinput('Log', 'Messages' )
	tlog.TaskOnceAdd( rcvLog )

	return self
end

-- Notification area at the bottom of the screen

local function f()
	local sw = psrf:GetWidth() - LeftBar.get():GetWidth()
	local sh = fsdigit:GetHeight()*4

	local self = TextArea( psrf, 
		LeftBar.get():GetWidth(),psrf:GetHeight()-sh, sw, sh,	-- Geometry
		fsdigit, COL_BLACK, { bgcolor=COL_LIGHTGREY } -- Font
	)

	local function rcvLog()	-- Receiving a log
		self.SmartCR()
		self.DrawString( SelShared.get('Log') )
	end

	tlog = MQTTinput('Log', 'nNotification/#' )
	tlog.TaskOnceAdd( rcvLog )

	self.refresh()
	return self
end

NotificationArea = f()

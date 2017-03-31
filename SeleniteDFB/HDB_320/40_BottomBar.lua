-- Notification area at the bottom of the screen

local function f()
	local sw = psrf:GetWidth() - LBw
	local sh = fstxt:GetHeight()*4

	local self = SubSurface( psrf, LBw, psrf:GetHeight()-sh, sw, sh )
	local sw, sh = self.get():GetSize()
	local srf = self.get()

--[[
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
--]]
	self.refresh()
	return self
end

BottomBar = f()

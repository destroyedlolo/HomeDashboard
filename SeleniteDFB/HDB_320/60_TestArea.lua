-- Scratch pad to test some function

local function f()
	self = SubSurface( psrf, 
		LeftBar.get():GetWidth(),0,
		psrf:GetWidth() - LeftBar.get():GetWidth(), psrf:GetHeight()
	)
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	text = TextArea( srf, 10,10, sw-20, sh-20, fsdigit, COL_BLACK, { bgcolor=COL_LIGHTGREY } )
	-- tlog = MQTTinput('Log', 'Marcel.prod/Log/Information' )
	tlog = MQTTinput('Log', 'nNotification/#' )

	local function revLog()
		text.CR()
		text.DrawString( SelShared.get('Marcel.prod/Log/Information') )
	end

	tlog.TaskOnceAdd( revLog )

	self.refresh()

	return self
end

TestArea = f()


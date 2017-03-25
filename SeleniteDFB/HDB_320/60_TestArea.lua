-- Scratch pad to test some function

local function f()
	self = SubSurface( psrf, 
		LeftBar.get():GetWidth(),0,
		psrf:GetWidth() - LeftBar.get():GetWidth(), psrf:GetHeight()
	)
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	-- Put a log of notification at the bottom of the screen
	text = TextArea( srf, 0, sh-fsdigit:GetHeight()*4 , sw, fsdigit:GetHeight()*4, fsdigit, COL_BLACK, { bgcolor=COL_LIGHTGREY } )
	-- tlog = MQTTinput('Log', 'Marcel.prod/Log/Information' )
	tlog = MQTTinput('Log', 'nNotification/#' )

	local function revLog()
		local x,y = text.getCSR()
		if x~=0 or y~=0 then	-- Scroll only if the display is not empty
			text.CR()
		end
		text.DrawString( SelShared.get('Log') )
	end

	tlog.TaskOnceAdd( revLog )

	self.refresh()

	return self
end

TestArea = f()


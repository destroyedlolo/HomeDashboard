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
		if udt == 0 then
			self.setColor( tcolor )
		elseif udt == 1 then
			self.setColor( COL_WHITE )
		elseif udt == 2 then
			self.setColor( COL_GREEN )
		elseif udt == 3 then
			self.setColor( COL_ORANGE )
		elseif udt == 4 then
			self.setColor( COL_RED )
		elseif udt == 5 then
			self.setColor( COL_DIGIT )
		else
			self.setColor( tcolor )
		end
		self.Log(txt)
	end

	return self
end

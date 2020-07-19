-- Notification area at the bottom of the screen

function NotificationArea(
	psrf,		-- Parent surface
	x,y, w,h,	-- Geometry
	font, tcolor,
	opts
)
--[[ known options  :
-- timeformat : display time of message arrival 
-- 		the argument if time format, see os.date()
-- 		(default : time not displayed)
-- timefont : font to use to display time (default font)
-- timecolor : font color (default : tcolor)
--]]
	if not opts then
		opts = {}
	end
	if not opts.timecolor then
		opts.timecolor = tcolor
	end

	local self = TextArea( psrf, x,y, w,h, font, tcolor, opts )

	local flipcol = true	-- Color flipping flag

	function self.Log( msg )
		self.SmartCR()
		self.DrawString( msg )
	end

	function self.Display( txt, udt )
		self.SmartCR()

		if opts.timeformat then
			if opts.timefont then
				self.setFont( opts.timefont )
			end
			self.setColor(opts.timecolor)
			self.DrawString( os.date(opts.timeformat) .." :  ", true )
			if opts.timefont then
				self.setFont( font )
			end
		end

		if udt == -1 then
			if flipcol == true then
				flipcol = false
				self.setColor( COL_GREY )
			else
				flipcol = true
				self.setColor( COL_LIGHTGREY )
			end
		elseif udt == 0 then
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
		self.DrawString( txt )
	end

	return self
end

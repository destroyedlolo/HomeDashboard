-- handle tracker's status

function SuiviTracker (
	name,
	topic,		-- topic to listen to
	condition,	-- condition to report to
	time		-- report time ending (optional)
)
	local self = MQTTinput( name, topic )

	function self.update()
		if self.get() == "CHECKING" then
			condition.force_issue()
			if time then
				time.Clear()
				time.Refresh()
			end
		elseif self.get() == "DONE" then
			condition.force_ok()
			if time then
				time.update( os.date("%H:%M") )
			end
		else
			condition.clear()
			if time then
				time.Clear()
				time.Refresh()
			end
		end
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self
end

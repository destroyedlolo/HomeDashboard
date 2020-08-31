-- Manage pool status

function SuiviSolaire (
	name,
	topic,		-- topic to listen to
	condition,	-- condition to report to
	time		-- report time, ending
)
	local self = MQTTinput( name, topic )

	function self.update()
		if self.get() == "CHECKING" then
			condition.force_issue()
			time.Clear()
			time.Refresh()
		elseif self.get() == "DONE" then
			condition.force_ok()
			time.update( os.date("%H:%M") )
		else
			condition.clear()
			time.Clear()
			time.Refresh()
		end
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self
end

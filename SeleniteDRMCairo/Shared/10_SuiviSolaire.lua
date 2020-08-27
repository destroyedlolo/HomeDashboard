-- Manage pool status

function SuiviSolaire (
	name,
	topic,		-- topic to listen to
	condition,	-- condition to report to
	time		-- report time, ending
)
	local self = MQTTinput( name, topic )

	function self.update()
		if self.get():sub(1,1) == 'E' then
			condition.force_issue()
			time.Clear()
			time.Refresh()
		elseif self.get():sub(1,1) == 'F' then
			condition.force_ok()
			time.update( self.get():sub(3,8) )
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

-- Manage "Livre d'Or" notification

function Lvdo(
	name,
	topic,		-- topic to listen to
	condition	-- condition to report to
)

	local self = MQTTinput( name, topic )

	function self.update()
		local _,m = string.match(self.get(), "(.*):(.*)")

		if m == 'CREATE' then
			condition.report_issue()
		elseif m == 'DELETE' then
			condition.issue_corrected()
		end
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self

end

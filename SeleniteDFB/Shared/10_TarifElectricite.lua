-- Manage Electricty rate

function TarifElectricite(
	name,
	topic,		-- topic to listen to
	condition	-- condition to report to
)
	local self = MQTTinput( name, topic )

	function self.update()
		if self.get() == 'HC..' then
			condition.report_issue()
		else
			condition.issue_corrected()
		end
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self
end

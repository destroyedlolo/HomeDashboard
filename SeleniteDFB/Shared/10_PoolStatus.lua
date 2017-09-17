-- Manage pool status

function PoolStatus (
	name,
	topic,		-- topic to listen to
	condition	-- condition to report to
)
	local self = MQTTinput( name, topic )

	function self.update()
		if self.get() == 'Arret' then
			condition.clear()
		elseif self.get() == 'Forcé' then
			condition.force_issue()
		elseif self.get() == 'HC1' then
			condition.force_ok()
		elseif self.get() == 'HC0' then
			condition.setColor(COL_DARKORANGE)
		end
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self
end

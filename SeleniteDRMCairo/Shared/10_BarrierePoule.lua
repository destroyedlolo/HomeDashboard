function BarrierePoule(
	name,
	topic,		-- topic to listen to
	condition	-- condition to report to
)

	local self = MQTTinput( name, topic )

	function self.update()
		if self.get() == 'Ouverte' then
			condition.force_issue()
		else
			condition.clear()
		end
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self
end

-- Manage UPS inputs

function UPSdata( name, topic, 
	func, 			-- validation function
	topicnominal,	-- topic for nominal power
	srf	-- surface to display the value
)
	local self = MQTTinput( name, topic, func )
	local nominal = MQTTinput( name .." nominal", topicnominal)

	function self.update()
		local v = self.get()
		local maxp = tonumber( SelShared.get('onduleur/ups.realpower.nominal') )

		if maxp then	-- we can calculate the real power
			srf.update( string.format('%3.1f', v*maxp/100) .. ' W' )
		else
			srf.update( v .. '%' )
		end
	end

	-- init
	self.TaskOnceAdd( self.update )

	return self
end

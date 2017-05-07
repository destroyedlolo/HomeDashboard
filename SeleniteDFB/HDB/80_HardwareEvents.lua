-- Handle tablet's keys

local evt0, evt1

local function handlekeys0()
	handleevent( evt0:read() )
end

local function handlekeys1()
	handleevent( evt1:read() )
end

evt0 = SelEvent.create('/dev/input/event0', handlekeys0)
evt1 = SelEvent.create('/dev/input/event1', handlekeys1)
table.insert( additionnalevents, evt0 )
table.insert( additionnalevents, evt1 )


-- Handle my BananaPI's event

local evt0, evt1

-- event0 : a KF-8000X remote control on sunxi-ir
-- As the only way to change key mapping is to recompile the kernel
-- I decided to simply create transcode table here
local KF_8000X_transcode = {
	[1] = 'VOLUMEUP',
	[17] = 'VOLUMEUP',
	[9] = 'VOLUMEDOWN',
	[25] = 'VOLUMEDOWN',
	[64] = 'SEARCH',
	[31] = 'POWER',
	[22] = 'EJECTCD'
}

local function handlekeys0()
	local t,tp,c,v = evt0:read()
	if KF_8000X_transcode[c] then
		c = SelEvent.KeyConst(KF_8000X_transcode[c])
	end
	handleevent( t,tp,c,v )
end

-- event1 : Power button on axp20-supplyer
local function handlekeys1()
	handleevent( evt1:read() )
end

evt0 = SelEvent.create('/dev/input/event0', handlekeys0)
evt1 = SelEvent.create('/dev/input/event1', handlekeys1)
table.insert( additionnalevents, evt0 )
table.insert( additionnalevents, evt1 )


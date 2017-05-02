-- Manage key events

-- Modes

local mode_default = {
-- type / key_name / value
	['KEY/VOLUMEDOWN/1'] = function () prevWindow( true ) end,
	['KEY/VOLUMEUP/1'] = function () nextWindow( true ) end
}

-- Actions

local mode =  mode_default	-- Active mode

function handleevent( tp, c, v )	-- (public has the function shall be called from elsewhere)
	local f = mode[ SelEvent.TypeName(tp) ..'/'.. SelEvent.KeyName(c) ..'/'.. v ]
	if f then
		f()
	end
end


-- Keys' event

local evt

local function handlekeys()
	local t, tp, c, v = evt:read()

	handleevent( tp, c, v )
end

evt = SelEvent.create('/dev/input/event1', handlekeys)
table.insert( additionnalevents, evt )


-- Fake keys

local function handlefakekeys()
	local t = SelEvent.TypeConst("KEY")

	if SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'VolD' then -- simulate VOLUMEDOWN
		handleevent( t, SelEvent.KeyConst("VOLUMEDOWN"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'VolU' then -- simulate VOLUMEUP
		handleevent( t, SelEvent.KeyConst("VOLUMEUP"), 1 )
	end
end

table.insert( Topics, 
	{ topic = 'HomeDashBoard/'.. MQTT_ClientID ..'/Key', trigger=handlefakekeys }
)
SelLog.log("*I* Listening on topic : HomeDashBoard/".. MQTT_ClientID ..'/Keys')

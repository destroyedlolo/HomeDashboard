-- Manage key events

-- Modes

local mode_default = {
-- type / key_name / value
	['KEY/VOLUMEDOWN/1'] = function () prevWindow( true ) end,
	['KEY/VOLUMEUP/1'] = function () nextWindow( true ) end,
	['KEY/POWER/1'] = function () SaveCollection() end
}

-- Actions

local mode =  mode_default	-- Active mode

function handleevent( t, tp, c, v )	-- (public has the function shall be called from elsewhere)
	local f = mode[ SelEvent.TypeName(tp) ..'/'.. SelEvent.KeyName(c) ..'/'.. v ]
	if f then
		f()
	else
		if v ~= 0 then -- Ignore key release when reporting unknown action
			Notification.Log( SelEvent.TypeName(tp) ..'/'.. SelEvent.KeyName(c) ..'/'.. v .. " : Action inconnue" )
			SelLog.log("*I* " .. SelEvent.TypeName(tp) ..'/'.. SelEvent.KeyName(c) ..'/'.. v .. " : Action inconnue" )
		end
	end
end


-- Keys' event

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


-- Fake keys

local function handlefakekeys()
	local t = SelEvent.TypeConst("KEY")

	if SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'VolD' then -- simulate VOLUMEDOWN
		handleevent( 0, t, SelEvent.KeyConst("VOLUMEDOWN"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'VolU' then -- simulate VOLUMEUP
		handleevent( 0, t, SelEvent.KeyConst("VOLUMEUP"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'S' then -- simulate SEARCH
		handleevent( 0, t, SelEvent.KeyConst("SEARCH"), 1 )
	elseif SelShared.get('HomeDashBoard/'.. MQTT_ClientID ..'/Key') == 'Pwr' then -- simulate POWER
		handleevent( 0, t, SelEvent.KeyConst("POWER"), 1 )
	end
end

table.insert( Topics, 
	{ topic = 'HomeDashBoard/'.. MQTT_ClientID ..'/Key', trigger=handlefakekeys }
)
SelLog.log("*I* Listening on topic : HomeDashBoard/".. MQTT_ClientID ..'/Keys')

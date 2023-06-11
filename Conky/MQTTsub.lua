-- Subscribe and expose some MQTT topics
-- (C) Laurent Faillie - 2015 : http://destroyedlolo.info
--
-- 02/06/2021 - Change to luamqtt

local mqtt = require "mqtt"

local broker_host = "torchwood.local"	-- Where to find the broker [:port]

---- End of configurable area ----
os.setlocale('C') -- otherwise, fail with locale where ',' is the decimal separator (FR)

-- Connect to the broker and subscribe to topics
-- https://github.com/xHasKx/luamqtt/blob/master/examples/sync.lua
function conky_init()
	client = mqtt.client{ uri = broker_host, clean = true }
print("Connected")

end

-- leaving, doing some cleaning
function conky_cleanup()
end

function conky_handlebroker() -- loop to handle messages
	if not brkc then	-- As it seems lua_draw_hook_pre is called before init :(
		return
	end

	mqtt.run_sync(client)

	if err then
		print('*E*',err);
	end
end


-- HDB configuration file
-- all local configuration change have to be made here

-- MQTT_URL='tcp://bpi.chez.moi:1883' -- URL where to connect to the broker
MQTT_URL='tcp://torchwood.chez.moi:1883' -- URL where to connect to the broker
MQTT_ClientID='HDBlcd-dev'	-- Broker client ID : must be unique across the system

-- Activate for debugging only
local _,err = SelLog.configure('/tmp/HDBlcd.log_' .. os.date('%Y%m%d'), false)
if err then
	print("*E* Log creation", err)
end

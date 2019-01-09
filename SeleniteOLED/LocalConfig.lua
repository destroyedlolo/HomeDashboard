-- HDB configuration file
-- all local configuration change have to be made here

MQTT_URL='tcp://xxxxxxxxx:1883' -- URL where to connect to the broker
MQTT_ClientID='HDBo-dev'	-- Broker client ID : must be unique across the system

-- Activate for debugging only
local _,err = SelLog.init('/tmp/HDBo.log_' .. os.date('%Y%m%d'), false)
if err then
	print("*E* Log creation", err)
end

-- As toile is in a dedicated directory in my dev environment ...
package.path = '/home/laurent/Projets/Toile/?.lua;' .. package.path


-- HDB configuration file
-- all local configuration change have to be made here

MQTT_URL='tcp://bpi.chez.moi:1883' -- URL where to connect to the broker
-- MQTT_URL='tcp://torchwood.chez.moi:1883' -- URL where to connect to the broker
MQTT_ClientID='TdB'	-- Broker client ID : must be unique across the system
MARCEL='Marcel.prod'
--MAJORDOME = 'Majordome'

-- Activate for debugging only
local _,err = SelLog.init('/tmp/HDB.log_' .. os.date('%Y%m%d'), false)
if err then
	print("*E* Log creation", err)
end

-- As toile is in a dedicated directory in my dev environment ...
print "**** DEV DEV DEV DEV *****"
package.path = '/home/laurent/Projets/?.lua;/home/laurent/Projets/?/init.lua;' .. package.path


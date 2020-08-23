-- HDB configuration file
-- all local configuration change have to be made here

MQTT_ClientID='HDBControl'	-- Broker client ID : must be unique across the system

--- Prod
MQTT_URL='tcp://actif.chez.moi:1883' -- URL where to connect to the broker
MAJORDOME="Majordome"

-- Dev
-- MQTT_URL='tcp://torchwood.chez.moi:1883' -- URL where to connect to the broker
-- MAJORDOME="Majordome.dev"

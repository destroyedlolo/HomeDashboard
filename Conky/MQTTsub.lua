-- Subscribe and expose some MQTT topics
-- (C) Laurent Faillie - 2015 : http://destroyedlolo.info

local MQTT = require "paho.mqtt"

local broker_host = "bpi.chez.moi"	-- Where to find the broker
local broker_port = 1883			-- at which port

local topics = {	-- Topics to subscribe
	EVtsd = {tpc = 'Freebox/DownloadATM'},
	EVtsu = {tpc = 'Freebox/UploadATM'},
	EMrgd = {tpc = 'Freebox/DownloadMarge'},
	EMrgu = {tpc = 'Freebox/UploadMarge'},
	EWANd = {tpc = 'Freebox/DownloadWAN'},
	EWANu = {tpc = 'Freebox/UploadWAN'},
	ETVd = {tpc = 'Freebox/DownloadTV'},
	ETVu = {tpc = 'Freebox/UploadTV'},
	ELand = {tpc = 'Freebox/DownloadLan'},
	ELanu = {tpc = 'Freebox/UploadLan'},

	Consomation = {tpc = 'TeleInfo/Consommation/values/PAPP', max=13200}, -- 220v * 60a
	Production = {tpc = 'TeleInfo/Production/values/PAPP', max=1900},

	vPiscine = {tpc='SondePiscine/Vcc', max=3300, min=2500},
	vPoulailler = {tpc='Poulailler/Alim', max=5000, min=4500},
	hPoulailler = {tpc='Poulailler/Perchoir/Humidite'},

	ups_voltage = {tpc = 'onduleur/input.voltage'},
	ups_load = {tpc = 'onduleur/ups.load', max=100},
	ups_load_nom = {tpc = 'onduleur/ups.realpower.nominal'},
	ups_battery = {tpc = 'onduleur/battery.charge', max=100},

	P_Garage = {tpc = 'maison/IO/Porte_Garage'},
	P_Cave = {tpc = 'maison/IO/Porte_Cave'},
	P_GSud = {tpc = 'maison/IO/Porte_GSud'},
	P_GNord = {tpc = 'maison/IO/Porte_GNord'},
	B_Poules = {tpc = 'maison/IO/Barriere_Poules'},

	Congelo = {tpc = 'maison/Temperature/Congelateur'},
	Piscine = {tpc = 'SondePiscine/TempPiscine'},
	Poulailler = {tpc = 'Poulailler/Perchoir/Temperature'},
	Bureau = {tpc = 'maison/Temperature/Bureau'},
	Garage = {tpc = 'maison/Temperature/Garage'},
	GarageP = {tpc = 'maison/Temperature/GarageP'},
	Comble = {tpc = 'maison/Temperature/Comble'},
	Dehors = {tpc = 'maison/Temperature/Dehors'},
	Salon = {tpc = 'maison/Temperature/Salon'},
	GrenierN= {tpc = 'maison/Temperature/Grenier Nord'},
	GrenierS= {tpc = 'maison/Temperature/Grenier Sud'},
	ChJoris= {tpc = 'maison/Temperature/Chambre Joris'},
	ChOceane= {tpc = 'maison/Temperature/Chambre Oceane'},
	ChParent= {tpc = 'maison/Temperature/Chambre Parents'},
	ChAmis = {tpc = 'maison/Temperature/Chambre Amis'}
}

---- End of configurable area ----
os.setlocale('C') -- otherwise, fail with locale where ',' is the decimal separator (FR)

-- Unfortunately, paho lib doesn't like keyed tables 
-- so we have to build a temporary collection
ttopics = {}
rtopics = {}
for k,v in pairs( topics ) do
	ttopics[ #ttopics + 1 ] = v.tpc
	rtopics[ v.tpc ] = k
end

function callback(
  topic,    -- string
  message)  -- string

-- debug only
--	print("Topic: " .. topic .. ", message: '" .. message .. "'")

	_G[ rtopics[ topic ] ] = message
end

-- Connect to the broker and subscribe to topics
function conky_init()
	brkc = MQTT.client.create( broker_host, broker_port, callback)
	brkc:connect( conky_parse( '$nodename' ) ..'_' .. os.getenv('USER') )
	brkc:subscribe( ttopics )
end

-- leaving, doing some cleaning
function conky_cleanup()
	brkc:unsubscribe(ttopics)
	brkc:destroy()
end

function conky_displayvar( var )
	if not _G[ var ] then
		return '????'
	else
		return tostring(_G[ var ])
	end
end

function conky_displayAccess( var )
	if not _G[ var ] then
		return '????'
	else
		if _G[ var ] == "Ouverte" then
			ret = "${color red}"
		else
			ret = "${color}"
		end
		return ret .. _G[ var ]
	end
end

function conky_displayvarCongelo( var, unite )
	if not _G[ var ] then
		return '????'
	else
		local ret = ""
		if tonumber(_G[ var ]) > -10 then
			ret = "${color red}"
		else
			ret = "${color}"
		end
		return ret..tostring(_G[ var ]).."${color grey} "..unite
	end
end


function conky_displayvarU( var, unite )
	if not _G[ var ] then
		return '????'
	else
		return tostring(_G[ var ]).."${color grey} "..unite
	end
end

function conky_getConso( )
	return Consomation
end

function conky_getProd( )
	return Production
end

function conky_getprc( var )
	if not _G[ var ] then
		return 0
	end

	if not topics[ var ].min then
		return 100*_G[ var ]/topics[ var ].max
	else
		local t = _G[ var ] - topics[ var ].min
		local delta = topics[ var ].max - topics[ var ].min
		if t < 0 then
			return 0
		else
			return 100 * t / delta
		end
	end
end

function conky_getCharge( )
	if not ups_load_nom or not ups_load then
		return '????'
	else
		return ups_load * ups_load_nom / 100
	end
end

function conky_getVPiscine( )
	if not vPiscine then
		return '????'
	else
		return vPiscine / 1000
	end
end

function conky_getVPoulailler( )
	if not vPoulailler then
		return '????'
	else
		return vPoulailler / 1000
	end
end

function conky_getHPoulailler( )
	if not hPoulailler then
		return '????'
	else
		return hPoulailler
	end
end

function conky_handlebroker() -- loop to handle messages
	if not brkc then	-- As it seems lua_draw_hook_pre is called before init :(
		return
	end

	local err = brkc:handler()

	if err then
		print('*E*',err);
	end
end


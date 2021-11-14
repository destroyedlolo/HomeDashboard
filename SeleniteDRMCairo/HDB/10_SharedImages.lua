-- Load images that are used in several objects

local err
DropImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Goutte.png")
if not DropImg then
	print("*E*",err)
	os.exit(EXIT_FAILURE)
end

BatteryImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Battery.png")
if not BatteryImg then
	print("*E*",err)
	os.exit(EXIT_FAILURE)
end

WiFiImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/WiFiicn.png")
if not WiFiImg then
	print("*E*",err)
	os.exit(EXIT_FAILURE)
end

MQTTImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/MQTT.png")
if not MQTTImg then
	print("*E*",err)
	os.exit(EXIT_FAILURE)
end


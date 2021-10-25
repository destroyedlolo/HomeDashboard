-- Load images that are used in several objects

local err
DropImg,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Goutte.png")
if not DropImg then
	print("*E*",err)
	os.exit(EXIT_FAILURE)
end

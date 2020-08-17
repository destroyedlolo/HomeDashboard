-- Display "HeureCreuse" icon

function HeureCreuse(
	psrf,			-- mother surface
	sx,sy,			-- position
	opts
)
	if not opts then
		opts = {}
	end

	local img,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/EuroVert.png")
	if not img then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end
	local sw,sh = img:GetSize()

	local self = ImageSurface(psrf, sx,sy, sw,sh)

	function self.getData()
		psrf.Clear({ sx,sy, sw,sh })
		if SelShared.Get("TarifEDF") == "HC.." then
			self.Update( img )
		else
			self.Refresh()
		end
	end

	local dt = MQTTinput( "TarifEDF", MAJORDOME .."/TarifElectricite" )
	dt.TaskOnceAdd( self.getData )
end

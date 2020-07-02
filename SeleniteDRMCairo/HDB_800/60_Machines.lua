-- Display running machine statistics

local function machines()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h )

	local motherboard,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Motherboard.png")
	if not motherboard then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear()
		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.setColor( COL_TITLE )
		self.setFont( fonts.title )
		self.get():DrawStringTop("Machines :", 5,0 )
		self.get():Blit(motherboard, 50,50)
	end

	self.Clear()

	local machines = {}
	MachinesCollection(machines, 8)

	for i=0,8 do
		machines[i] = Machine(
			self, 
			5 + 215*(i%3), 45 + 128*math.floor(i/3), 
			200,105, 
			fonts.sdigit, COL_TITLE
		)
	end

	self.Visibility(true)
	return self
end

Machines = machines()

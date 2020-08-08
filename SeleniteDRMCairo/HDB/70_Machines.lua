-- Display running machine statistics

local function machines()
	local self = Surface( psrf, WINTOP.x, WINTOP.y, WINSIZE.w, WINSIZE.h, 
		{
			keepcontent = true
		}
	)

	local motherboard,err = SelDCSurfaceImage.createFromPNG(SELENE_SCRIPT_DIR .. "/Images/Motherboard.png")
	if not motherboard then
		print("*E*",err)
		os.exit(EXIT_FAILURE)
	end

	function self.Clear(
		clipped -- Clipping region
	)
		-- Restrict drawing area
		if clipped then	-- Offset this surface
			self.get():SaveContext()
			self.get():SetClipS( unpack(clipped) )
		end
	
		-- Redraw window's background
		self.get():Clear( COL_BLACK.get() )
		self.setColor( COL_TITLE )
		self.setFont( fonts.title )
		self.get():DrawStringTop("Machines :", 5,0 )
		self.get():Blit(motherboard, 50,50)

		if clipped then
			self.get():RestoreContext()
		end
	end

	self.Clear()

	local machines = {}
	MachinesCollection(machines, 8)

	for i=0,8 do
		machines[i] = Machine(
			self, 
			5 + 215*(i%3), 45 + 128*math.floor(i/3), 
			200,105, 
			fonts.sdigit, COL_TITLE,
			{
				timeout = 150
			}
		)
	end

	self.Visibility(false)
	return self
end

Machines = machines()

table.insert( winlist, Machines )


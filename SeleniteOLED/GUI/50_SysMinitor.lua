-- Local figures

function SysMonitor()
	local f = io.open('/proc/loadavg','r')
	local r1 = f:read('*n')
	f:close()

	f = io.open('/proc/meminfo','r')
	local mtotal, mfree, stotal, sfree
	for l in f:lines() do
		local tok, v = l:match("(%a+):%s*(%d+)")
		v = tonumber(v)

		if tok == "MemTotal" then
			mtotal = v
		elseif tok == "MemFree" then
			mfree = v
		elseif tok == "SwapTotal" then
			stotal = v
		elseif tok == "SwapFree" then
			sfree = v
		end
	end
	f:close()

	SelOLED.Clear()
	SelOLED.SetTextColor(1)
	SelOLED.SetTextSize(2)
	SelOLED.SetCursor(0,0)
	SelOLED.Print(Selene.Hostname())

	SelOLED.SetTextSize(1)
	SelOLED.SetCursor(0,19)
	SelOLED.Print("CPU : " .. string.format("%0.2f",r1))
	local max = math.ceil(r1)
	SelOLED.SetCursor(116,19)
	SelOLED.Print(string.format("%2d", max))
	SelOLED.HorizontalGauge(0,29, SelOLED.Width(),6, r1/max*100)

	SelOLED.SetCursor(0,38)
	local pmem = mfree / mtotal * 100
	local pswap = sfree / stotal * 100
	SelOLED.Print(
		"MEM :" .. string.format("%3d%%",100-pmem) ..
		"  Swap :" .. string.format("%3d%%",100-pswap)
	)
	SelOLED.HorizontalGauge(0,48, SelOLED.Width()/2-2,6, 100-pmem)
	SelOLED.HorizontalGauge(SelOLED.Width()/2+2,48, SelOLED.Width()/2-2,6, 100-pswap)

	SelOLED.Display()
end

table.insert( winlist, SysMonitor )

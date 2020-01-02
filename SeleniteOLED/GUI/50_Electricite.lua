function f()
	local self = {}

	self.name = "Electricite"

	local gvolt = GfxArea( 68, 0,
		SelOLED.Width()-68, 16,
		{ bbottom_pattern=0x8282, bleft_pattern=0x8282 }
	)
	local voltage = MQTTStoreGfx( 'voltage', 'onduleur/input.voltage', nil, nil,
		{ width=SelOLED.Width()-68 }
	)
	table.insert( savedcols, voltage )

	local gconso = GfxArea( 35, 19, 
		SelOLED.Width()-36, 16,
		{ bbottom_pattern=0x8282, bleft_pattern=0x8282 }
	)
	local consomation = MQTTStoreGfx( 'consommation', 'TeleInfo/Consommation/values/PAPP', nil, nil,
		{ width=SelOLED.Width()-36 }
	)
	table.insert( savedcols, consomation )

	local gprod = GfxArea( 35, 44, 
		SelOLED.Width()-36, 16,
		{ bbottom_pattern=0x8282, bleft_pattern=0x8282 }
	)
	local production = MQTTStoreGfx( 'production', 'TeleInfo/Production/values/PAPP', nil, nil,
		{ width=SelOLED.Width()-36 }
	)
	table.insert( savedcols, production )

	function self.display ()
		-- Refresh only if we are displaying the right window

		if winlist[wcnt+1].name ~= self.name then
			return
		end

		SelOLED.Clear()
		SelOLED.SetTextColor(1)
		SelOLED.SetTextSize(2)
		SelOLED.SetCursor(0,0)
		local l=SelShared.Get('voltage')
		if l then
			l = string.match(l, "%d+")
		else
			l = "___"
		end
		SelOLED.Print(l .. "V")
		local min,max = voltage.getCollection():MinMax()
		SelOLED.SetTextSize(1)
		SelOLED.SetCursor(49,0)
		if min then
			SelOLED.Print(max or "---")
		else
			SelOLED.Print("---")
		end
		SelOLED.SetCursor(49,8)
		SelOLED.Print(min or "---")
		gvolt.DrawGfx(voltage.getCollection(), voltage.getOpts().forced_min)
--[[
	SelOLED.Line(50, 19, SelOLED.Width(), 19)
	SelOLED.Line(50, 19, 50, 36)
]]

		SelOLED.SetTextSize(1)
		SelOLED.SetCursor(0,19)
		SelOLED.Print("Conso\n")
--	SelOLED.SetCursor(0,27)
		SelOLED.Print( (SelShared.Get('consommation') or "____") .."\n\n")
		gprod.DrawGfx(production.getCollection(), production.getOpts().forced_min)
		SelOLED.Print("Prod\n")
--	SelOLED.SetCursor(0,51)
		SelOLED.Print( (SelShared.Get('production') or "____") .."\n\n")
		gconso.DrawGfx(consomation.getCollection(), consomation.getOpts().forced_min)

		SelOLED.Display()
SelOLED.SaveToPBM("/tmp/tst.pbm")
	end

	return self
end

Electricite = f()
table.insert( winlist, Electricite )

--[[
local ltopics = {
	{ topic = 'onduleur/input.voltage' },
	{ topic = 'TeleInfo/Consommation/values/PAPP', trigger=Electricite.display, trigger_once=true },
	{ topic = 'TeleInfo/Production/values/PAPP', trigger=Electricite.display, trigger_once=true },
}

TableMerge( Topics, ltopics)
--]]

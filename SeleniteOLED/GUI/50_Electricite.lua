function f()
	local self = {}

	self.name = "Electricite"

	function self.display ()
		-- Refresh only if we are displaying the right window

		if winlist[wcnt+1].name ~= self.name then
			return
		end

		SelOLED.Clear()
		SelOLED.SetTextColor(1)
		SelOLED.SetTextSize(2)
		SelOLED.SetCursor(0,0)
		SelOLED.Print("ElectriciT")

		SelOLED.SetTextSize(1)
		SelOLED.SetCursor(0,19)
		SelOLED.Print("conso\n")
--	SelOLED.SetCursor(0,27)
		SelOLED.Print( (SelShared.Get('TeleInfo/Consommation/values/PAPP') or "____") .."\n\n")
		SelOLED.Print("Prod\n")
--	SelOLED.SetCursor(0,51)
		SelOLED.Print( (SelShared.Get('TeleInfo/Production/values/PAPP') or "____") .."\n\n")

		SelOLED.Display()
	end

	return self
end

Electricite = f()
table.insert( winlist, Electricite )

local ltopics = {
	{ topic = 'TeleInfo/Consommation/values/PAPP', trigger=Electricite.display, trigger_once=true },
	{ topic = 'TeleInfo/Production/values/PAPP', trigger=Electricite.display, trigger_once=true },
}

TableMerge( Topics, ltopics)

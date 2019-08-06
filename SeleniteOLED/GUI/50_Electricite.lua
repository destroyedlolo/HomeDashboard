function Electricite()
	local self = {}

	self.name = "Electricite"

	function self.display ()
		SelOLED.Clear()
		SelOLED.SetTextColor(1)
		SelOLED.SetTextSize(2)
		SelOLED.SetCursor(0,0)
		SelOLED.Print("ElectriciT")

		SelOLED.SetTextSize(1)
		SelOLED.SetCursor(0,19)
		SelOLED.Print("conso\n")
--	SelOLED.SetCursor(0,27)
		SelOLED.Print("____\n\n")
		SelOLED.Print("Prod\n")
--	SelOLED.SetCursor(0,51)
		SelOLED.Print("____\n\n")

		SelOLED.Display()
	end

	return self
end
table.insert( winlist, Electricite() )

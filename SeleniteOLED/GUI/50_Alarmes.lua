function f()
	local self={}

	self.name = 'Alarmes'

	local gcongelo = GfxArea( 68, 0, 
		SelOLED.Width()-68, 16,
		{ bbottom_pattern=0x8282, bleft_pattern=0x8282 }
	)
	local congelo = MQTTStoreGfx( 'congelo', 'maison/Temperature/Congelateur',
		nil, nil,
		{ width=SelOLED.Width()-68 }
	)
	table.insert( savedcols, congelo )

	function self.display ()
		if winlist[wcnt+1].name ~= self.name then
			return
		end

		SelOLED.Clear()
		gcongelo.DrawGfx(congelo.getCollection(), congelo.getOpts().forced_min)

		local l=SelShared.Get('congelo')
		if l then
			l = tonumber(l)
			if l > -10 then
				SelOLED.SetTextColor(0,1)
			else
				SelOLED.SetTextColor(1,0)
			end
			SelOLED.SetTextSize(2)
			SelOLED.SetCursor(0,0)
			SelOLED.Print(l)
		end
	
		SelOLED.Display()
		-- SelOLED.SaveToPBM("/tmp/tst.pbm")
	end

	return self
end

Alarmes = f()
table.insert( winlist, Alarmes )


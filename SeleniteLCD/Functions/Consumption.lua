-- Display electricity consumption

function updateConsumption()
	lcd:Home()
	lcd:WriteString(string.char(4))
	lcd:WriteString(string.format("%6d", SelSharedVar.Get('TeleInfo/Consommation/values/PAPP')))
	lcd:WriteString(string.char(6))
end

TableMerge( Topics, {{ topic='TeleInfo/Consommation/values/PAPP', trigger=updateConsumption, trigger_once=true }} )


-- Display electricity consumption

function updateProduction()
	lcd:SetCursor(9,0)
	lcd:WriteString(string.char(3))
	lcd:WriteString(string.format("%5d", SelSharedVar.Get('TeleInfo/LinkyProduction/values/SINSTI')))
	lcd:WriteString(string.char(6))
end

TableMerge( Topics, {{ topic='TeleInfo/LinkyProduction/values/SINSTI', trigger=updateProduction, trigger_once=true }} )


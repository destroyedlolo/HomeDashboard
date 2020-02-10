-- Listen doors topics

table.insert( Topics, { topic = 'maison/IO/Porte_GSud' } )
table.insert( Topics, { topic = 'maison/IO/Porte_GNord' } )
table.insert( Topics, { topic = 'maison/IO/Barriere_Poules' } )
table.insert( Topics, { topic = 'maison/IO/Porte_Garage', trigger=resetWD, trigger_once=true } )
table.insert( Topics, { topic = 'maison/IO/Porte_Cave', trigger=resetWD, trigger_once=true } )

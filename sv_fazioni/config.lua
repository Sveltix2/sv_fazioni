Config = {}

Config.Fatture = {
    "mechanic", 'bennys', 'casino'  --nomi dei job con il menu fattura [F6]
}

Config.Distanza = 2 --Distanza per invio fattura, consigliato 1/3 

Config.SlotDepositi = 50 --slot a disposizione per i depositi

Config.KGmassimiDepositi = 10 --Capienza in KG del deposito      DA CAMBIARE PRIMA DEL PRIMO AVVIO DELLA RISORSA

Config.GradoDeposito = 4 --grado minimo per accedere al deposito [ES: 4 = SOLO BOSS]

Config.Fazioni = {
    ['Los Santos Customs'] = {  --label
        deposito = {
            vector3(-364.5231, -111.4154, 38.68201), --coordinate depositi
        },
        ["bossmenu"] = {['grado'] = 0, ['pos'] = vector3(134.7956, -1029.389, 29.34729)}, --coordinate e grado minimo bossmenu
        ['job'] = "mechanic", --nome del job
        ['puliziasoldi'] = true  --se pulire o no i soldi dal boss menu
    },
}

Config.SpawnerVeicoli = {
    ['mechanic'] = {-- nome job
        ['marker'] = vector3(-366.4484, -118.2462, 38.68201),      -- coordinate   
        ["label"] = {"Camion"},--label dei veicoli
        ["veicolo"] = {"flatbed"},   --nome modelli veicoli                                          
        ["heading"] = 258.71,
        ["livrea"] = 1,
        ["colore1"] = 12, --colore primario [lasciare a 0 se lo vuoi casuale]
        ["colore2"] = 12,  --colore secondario [lasciare a 0 se lo vuoi casuale]
        ["perlescenza"] = -1,  --perlescenza [lasciare a -1 se lo vuoi casuale o 0 per non averla]
        ["motore"] = 12,  --da 1 a 4
        ["turbo"] = 12,  --da 1 a 4
        ["targa"] = '12345678910' --MAX 8 Caratteri
    },
--   ['bennys'] = { -- nome job
--        ['marker'] = vector3(122.4659, -1003.727, 29.39783),      -- coordinate 
--        ["label"] = {"Camion Piattaforma", "Elicottero"}, --label dei veicoli
--        ["veicolo"] = {"adder", 'polmav'}, --nome modelli veicoli                                         
--        ["heading"] = 258.71,
--        ["livrea"] = 1,
--        ["colore1"] = 12, --colore primario [lasciare a 0 se lo vuoi casuale]
--        ["colore2"] = 12,  --colore secondario [lasciare a 0 se lo vuoi casuale]
--        ["perlescenza"] = -1,  --perlescenza [lasciare a -1 se lo vuoi casuale o 0 per non averla]
--        ["motore"] = 12,  --da 1 a 4
--        ["turbo"] = 12,  --da 1 a 4
--        ["targa"] = '12345678910' --MAX 8 Caratteri
--    },
}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

print('^6--------------------------^0CREATED BY ^3Sveltix♱#2064^0^6--------------------------^0')

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function puo()
	for k,v in pairs(Config.Fatture) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
	for k, v in pairs(Config.Fazioni) do 	
		for key, coords in pairs(v.deposito) do
			TriggerEvent('gridsystem:registerMarker', {
				name = "inventari"..k,
				type = 21,
				pos = vector3(129.5077, -1028.967, 29.34729),
				color = { r = 255, g = 83, b = 26 },
				scale = vector3(0.4, 0.4, 0.4),
				permission = v.job,
				action = function()
					exports.ox_inventory:openInventory('stash', {id=v.job})
				end,
				onExit = function()
					ESX.UI.Menu.CloseAll()
				end,
				msg = "Premi ~INPUT_PICKUP~ per accedere al deposito",
			})
		end
	end
	--
	for k, v in pairs(Config.SpawnerVeicoli) do 	
		TriggerEvent('gridsystem:registerMarker', {
			name = "veicoli"..k,
			type = 21,
			pos = v.marker,
			color = { r = 255, g = 83, b = 26 },
			scale = vector3(0.4, 0.4, 0.4),
			permission = v.job,
			action = function()
				Veicoli()
			end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end,
			msg = "Premi ~INPUT_PICKUP~ per interagire",
		})
	end
	--
	for k, v in pairs(Config.Fazioni) do 	
		TriggerEvent('gridsystem:registerMarker', {
			name = "bossmenu"..k,
			type = 21,
			pos = v.bossmenu.pos,
			color = { r = 255, g = 83, b = 26 },
			scale = vector3(0.4, 0.4, 0.4),
			permission = v.job,
			grade = 4,
			action = function()
				TriggerEvent('esx_society:openBossMenu', v.job, function(data, menu)
					menu.close()
				end, { wash = v.puliziasoldi })
			end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end,
			msg = "Premi ~INPUT_PICKUP~ per interagire",
		})
	end
	--
end)

Veicoli = function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	for k, v in pairs(Config.SpawnerVeicoli) do 	
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			TriggerEvent('esx:deleteVehicle')
			ESX.ShowNotification('Hai depositato il veicolo')			
		else
			elements = {}

			for i=1, #v.veicolo, 1 do
				table.insert(elements, {label = v.label[i], value = v.veicolo[i]})
			end
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'prendi_veicolo',
				{
					title    = 'MENU',
					elements = elements
				},
				function(data, menu)
					local val = data.current.value
					
						if data.current.value then
						menu.close()	
						ESX.Game.SpawnVehicle(data.current.value, v.marker, v.heading, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle,{modTurbo = v.turbo, modEngine = v.motore, modLivery = v.livrea, pearlescentColor = v.perlescenza, plate = v.targa})
							if v.colore1 > 0 and v.colore2 > 0 then
								SetVehicleColours(vehicle, v.colore1, v.colore2)
							end
							TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)

							ESX.ShowNotification('Hai tirato fuori un veicolo dal garage')
						end)
					end
				end,
				function(data, menu)
					menu.close()
				end
			)		 
		end	
			
	end
end


RegisterKeyMapping('+fatture', 'Menù Fatture', 'keyboard', "F6")

RegisterCommand('+fatture', function()	
	if puo() then
		menu()
	else
		ESX.ShowNotification('Non puoi farlo!')
	end
end)

function menu()
	local elements = {}
 
	table.insert(elements, {label = "Manda Fattura", value = 'fattura'})
 
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fat', {
		title    = "Menu Fattura",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local selezionato = data.current.value
		
		if selezionato == 'fattura' then
		   fatture()
		end

	end, function(data, menu)
		menu.close()
	end)				
end

fatture = function()
    local lavoro = ESX.PlayerData.job.name
	local motivo = ESX.PlayerData.job.label
	local vicino, distanza = ESX.Game.GetClosestPlayer()

	if vicino == -1 or distanza > Config.Distanza then
		ESX.ShowNotification("Nessun giocatore vicino")
	else
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialogo',
		{
			title = "Importo [DESTINATARIO: ^1"..vicino.."^0 ]"
		}, function(data, menu)
	
			local quanto = tonumber(data.value)
	
			if vicino == -1 or distanza > Config.Distanza then
				ESX.ShowNotification("Nessun giocatore vicino")
			end
			if quanto == nil then
				ESX.ShowNotification("Importo non valido", "error")
			else
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('esx_billing:sendBill', vicino, lavoro, motivo, quanto)
			end
	
		end, function(data, menu)
			ESX.UI.Menu.CloseAll()
		end)
	end
end

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	for k, v in pairs(Config.Fazioni) do
		TriggerEvent('esx_society:registerSociety', v.job, v.job, 'society_' .. v.job, 'society_' .. v.job, 'society_' .. v.job, {type = 'public'})
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	for k, v in pairs(Config.Fazioni) do
		exports.ox_inventory:RegisterStash(v.job, k, Config.SlotDepositi, Config.KGmassimiDepositi) 
	end
end)


print('^6--------------------------^0CREATED BY ^3Sveltix♱#2064^0^6--------------------------^0')
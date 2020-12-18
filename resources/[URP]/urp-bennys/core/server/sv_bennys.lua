URPCore = nil
TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)
local chicken = vehicleBaseRepairCost

RegisterServerEvent('urp-bennys:attemptPurchase')
AddEventHandler('urp-bennys:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local xPlayer = URPCore.GetPlayerFromId(source)
    if type == "repair" then
        if xPlayer.getMoney() >= chicken then
            xPlayer.removeMoney(chicken)
            TriggerClientEvent('urp-bennys:purchaseSuccessful', source)
        else
            TriggerClientEvent('urp-bennys:purchaseFailed', source)
        end
    elseif type == "performance" then
        if xPlayer.getMoney() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('urp-bennys:purchaseSuccessful', source)
            xPlayer.removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('urp-bennys:purchaseFailed', source)
        end
    else
        if xPlayer.getMoney() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('urp-bennys:purchaseSuccessful', source)
            xPlayer.removeMoney(vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('urp-bennys:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('urp-bennys:updateRepairCost')
AddEventHandler('urp-bennys:updateRepairCost', function(cost)
    chicken = cost
end)

RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(myCar)
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
	{
		['@plate']   = myCar.plate,
		['@vehicle'] = json.encode(myCar)
	})
end)
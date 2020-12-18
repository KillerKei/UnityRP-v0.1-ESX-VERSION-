URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

RegisterServerEvent('carfill:pay')
AddEventHandler('carfill:pay', function(cash)
    local source = source
    local xPlayer = URPCore.GetPlayerFromId(source)
    if cash > 0 then
        xPlayer.removeMoney(cash)
        TriggerClientEvent("banking:removeBalance", cash)
    end
end)
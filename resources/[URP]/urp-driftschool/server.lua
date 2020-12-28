URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

RegisterServerEvent('urp-driftschool:takemoney')
AddEventHandler('urp-driftschool:takemoney', function(money)
    local source = source
    local xPlayer = URPCore.GetPlayerFromId(source)
    if xPlayer.getMoney() >= money then
        xPlayer.removeMoney(money)
        TriggerClientEvent("banking:removeBalance", money)
        TriggerClientEvent('urp-driftschool:tookmoney', source, true)
    else
        TriggerClientEvent('DoLongHudText', source, 'Not enough money', 2)
    end
end)
URPCore = nil
TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

RegisterServerEvent("contract:send")
AddEventHandler("contract:send", function(target, conamount, coninformation)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(target)

    if xPlayer then
        if conamount and type(tonumber(conamount)) == 'number' then
            TriggerClientEvent("contract:requestaccept", xPlayer.source, conamount,coninformation, src)
        else
            TriggerClientEvent('notification', src, 'Invaild contract amount.', 2)
        end
    else
        TriggerClientEvent('notification', src, 'Citizen not found.', 2)
    end
end)

RegisterServerEvent("contract:accept")
AddEventHandler("contract:accept", function(price,strg,target,accepted)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    local xTarget = URPCore.GetPlayerFromId(target)

    if accepted then
        if xPlayer.getMoney() >= tonumber(price) then
            TriggerClientEvent('notification', target, 'The citizen accepted your contract and paid $' .. price .. '.')
            xPlayer.removeMoney(price)
            xTarget.addMoney(price)
        else
            TriggerClientEvent('notification', src, 'You dont have enough money.', 2)
        end
    else
        TriggerClientEvent('notification', target, 'The citizen denied your contract.', 2)
    end
end)

--URPCore.RegisterUsableItem("contract", function(source)
-- ----   TriggerClientEvent("startcontract", source)
--end)

RegisterCommand("contract", function(source)
    TriggerClientEvent("startcontract", source)
end)

--
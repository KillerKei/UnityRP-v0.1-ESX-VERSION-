URPCore = nil
TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

-- Helper function for getting player money
function getMoney(source)
    local xPlayer = URPCore.GetPlayerFromId(source)
    local getmoney = xPlayer.getMoney()
    return getmoney
end

-- Helper function for removing player money
function removeMoney(source, amount)
    local xPlayer = URPCore.GetPlayerFromId(source)
    xPlayer.removeMoney(amount)
    TriggerClientEvent("banking:removeBalance", amount)
end

-- Helper function for adding player money
function addMoney(source, amount)
    local xPlayer = URPCore.GetPlayerFromId(source)
    xPlayer.addMoney(amount)
    TriggerClientEvent("banking:addBalance", amount)
end
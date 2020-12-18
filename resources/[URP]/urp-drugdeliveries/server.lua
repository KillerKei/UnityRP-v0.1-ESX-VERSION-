URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)
local src = source
local xPlayer = URPCore.GetPlayerFromId(src)

local stolenGoodsTable = {
	[84] = "stolencasiowatch",
	[85] = "rolexwatch",
	[86] = "stoleniphone",
	[87] = "stolens8",
	[88] = "stolennokia",
	[89] = "stolenpixel3",
	[90] = "stolen2ctchain",
	[91] = "stolen5ctchain",
	[92] = "stolen8ctchain",
	[93] = "stolen10ctchain",
	[94] = "stolenraybans",
	[95] = "stolenoakleys",
	[96] = "stolengameboy",
	[97] = "stolenpsp",
}

RegisterServerEvent('drugdelivery:server')
AddEventHandler('drugdelivery:server', function()
    local source = source
    local xPlayer = URPCore.GetPlayerFromId(source)
    if xPlayer.getMoney() >= 100 then
        xPlayer.removeMoney(100)
        TriggerClientEvent('drugdelivery:startDealing', source)
        TriggerClientEvent('drugdelivery:client', source)
    else
        TriggerClientEvent('DoLongHudText', source, 'You do not have enough money to start!', 2)
    end
end)

RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function(money)
    local source = source
    local xPlayer = URPCore.GetPlayerFromId(source)
    if xPlayer.getMoney() >= money then
        xPlayer.removeMoney(money)
        TriggerClientEvent('oxydelivery:startDealing', source)
        TriggerClientEvent('oxydelivery:client', source)
    else
        TriggerClientEvent('DoLongHudText', source, 'You do not have enough money to start!', 2)
    end
end)

RegisterServerEvent('delmission:completed')
AddEventHandler('delmission:completed', function(money)
    local source = source
    local xPlayer  = URPCore.GetPlayerFromId(source)
    if money ~= nil then
        xPlayer.addMoney(money)
    end
end)

local counter = 0
RegisterServerEvent('delivery:status')
AddEventHandler('delivery:status', function(status)
    if status == -1 then
        counter = 0
    elseif status == 1 then
        counter = 2
    end
    TriggerClientEvent('delivery:deliverables', -1, counter, math.random(1,14))
end)
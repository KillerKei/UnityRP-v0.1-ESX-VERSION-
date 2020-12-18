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

 RegisterServerEvent('mission:completed')
 AddEventHandler('mission:completed', function(moneyneeded)
 	local xPlayer = URP.GetPlayerFromId(source)
     xPlayer.addMoney(moneyneeded)
 end)

RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function(money)
	local shit = URPCore.GetPlayerFromId(source)

	if shit.money(money) >= money then
		xPlayer.removeMoney(money)
		
		TriggerClientEvent("drugdelivery:startDealing", source)
    else
        TriggerClientEvent('notification', source, 'You dont have enough money.', 2)
	end
end)

RegisterServerEvent('drugdelivery:server')
AddEventHandler('drugdelivery:server', function(money)
	local shit = URPCore.GetPlayerFromId(source)

	if shit.money(money) >= money then
		xPlayer.removeMoney(money)
		
		TriggerClientEvent("oxydelivery:startDealing", source)
    else
        TriggerClientEvent('notification', source, 'You dont have enough money.', 2)
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
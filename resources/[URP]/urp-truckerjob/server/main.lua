URPCore = nil
TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

RegisterServerEvent('urp-truckerjob:pay')
AddEventHandler('urp-truckerjob:pay', function(amount)
	local _source = source
	local xPlayer = URPCore.GetPlayerFromId(_source)
	local payout = math.random(1,2)
	local matherino = math.random(0, 2)
	xPlayer.addMoney(tonumber(amount))
	TriggerClientEvent("banking:addBalance", amount)
	if matherino < 2 then
		xPlayer.addInventoryItem('plastic', payout)
	end
end)

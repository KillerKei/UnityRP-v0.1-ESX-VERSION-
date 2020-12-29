URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

RegisterServerEvent('urp-uberkdshfksksdhfskdjjob:pay')
AddEventHandler('urp-uberkdshfksksdhfskdjjob:pay', function(amount)
	local _source = source
	local xPlayer = URPCore.GetPlayerFromId(_source)
	xPlayer.addMoney(tonumber(amount))
	TriggerClientEvent('chatMessagess', _source, '', 4, 'You got payed $' .. amount)
end)

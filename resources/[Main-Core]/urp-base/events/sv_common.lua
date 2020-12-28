URPCore                      = {}
URPCore.Players              = {}
URPCore.ServerCallbacks      = {}
URPCore.TimeoutCount         = -1
URPCore.CancelledTimeouts    = {}
URPCore.LastPlayerData       = {}
URPCore.Pickups              = {}
URPCore.PickupId             = 0
URPCore.Jobs                 = {}

AddEventHandler('urp:getSharedObject', function(cb)
	cb(URPCore)
end)

function getSharedObject()
	return URPCore
end

MySQL.ready(function()

	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=1, #result do
		URPCore.Jobs[result[i].name] = result[i]
		URPCore.Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

	for i=1, #result2 do
		if URPCore.Jobs[result2[i].job_name] then
			URPCore.Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
		else
			print(('urp-base: invalid job "%s" from table job_grades ignored!'):format(result2[i].job_name))
		end
	end

	for k,v in pairs(URPCore.Jobs) do
		if next(v.grades) == nil then
			URPCore.Jobs[v.name] = nil
			print(('urp-base: ignoring job "%s" due to missing job grades!'):format(v.name))
		end
	end
end)

AddEventHandler('urp:playerLoaded', function(source)
	local xPlayer         = URPCore.GetPlayerFromId(source)
	local accounts        = {}
	local xPlayerAccounts = xPlayer.getAccounts()

	for i=1, #xPlayerAccounts, 1 do
		accounts[xPlayerAccounts[i].name] = xPlayerAccounts[i].money
	end

	URPCore.LastPlayerData[source] = {
		accounts = accounts
	}
end)

RegisterServerEvent('urp:clientLog')
AddEventHandler('urp:clientLog', function(msg)
	RconPrint(msg .. "\n")
end)

RegisterServerEvent('urp:triggerServerCallback')
AddEventHandler('urp:triggerServerCallback', function(name, requestId, ...)
	local _source = source

	URPCore.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('urp:serverCallback', _source, requestId, ...)
	end, ...)
end)

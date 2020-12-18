RegisterServerEvent("np-base:playerSessionStarted")
AddEventHandler("np-base:playerSessionStarted", function()
    local civ = source
	-- TriggerEvent('fu:commands:build', source)
	Citizen.CreateThread(function()
		local identifier = GetPlayerIdentifiers(civ)[1]
		if not identifier then
			DropPlayer(civ, "No Identifier")
		end
		return
	end)
end)



RegisterServerEvent('np-base:loadPlayer')
AddEventHandler('np-base:loadPlayer', function(id)
local src = source
	exports.ghmattimysql:execute('SELECT * FROM characters WHERE id = ?', {id}, function(result)
		-- TriggerClientEvent('updatecid', id)
		-- TriggerClientEvent('updateNameClient', result[1].full_name, result[1].last_name)
		-- TriggerClientEvent('banking:updateBalance', result[1].bank)
		-- TriggerClientEvent('np-base:addedMoney', result[1].cash)
	end)
end)

RegisterServerEvent('np-base:doesExist')
AddEventHandler('np-base:doesExist', function(id, cb)
	exports.ghmattimysql:execute('SELECT * FROM characters WHERE id = ?', {id}, function(result)
		if result[1].id ~= nil then
			cb = true
		end
	end)
end)
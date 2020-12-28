ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("sup-stress:add")
AddEventHandler("sup-stress:add", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	-- if xPlayer.job.name == "police" then
	-- 	TriggerClientEvent("esx_status:add", _source, "stress", value / 10)
	-- else
        TriggerClientEvent("esx_status:add", _source, "stress", value)
        -- TriggerClientEvent('sup-notif', _source, 'Stresin arttı', 3)
	-- end
end)

RegisterServerEvent("sup-stress:remove")
AddEventHandler("sup-stress:remove", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("esx_status:remove", _source, "stress", value)
    TriggerClientEvent('sup-notif', _source, 'Stresin azaldı', 3)
end)
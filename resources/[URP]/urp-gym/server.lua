RegisterServerEvent('server:pass')
AddEventHandler('server:pass', function(data, args)
TriggerClientEvent('client:pass', source, data)
end)
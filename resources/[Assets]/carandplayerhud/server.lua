RegisterCommand('roll', function(source, args)
    local times = args[1]
    print(times)
    local weight = args[2]
    print(weight)

    TriggerClientEvent('roll', source, times, weight)
end)
local penis = {
    [1] = "np-base:selectCharacter",
    [2] = "np-base:createCharacter",
    [3] = "np-base:fetchPlayerCharacters",
    [4] = "np-base:loginPlayer",
    [5] = "fuck"
}



RegisterServerEvent('np-events:listenEvent')
AddEventHandler('np-events:listenEvent', function(id, event, args)
    if event == penis[1] then 
        TriggerEvent('np-base:selectCharacter', args)
    elseif event == penis[2] then 
        TriggerEvent('np-base:createCharacter', args)
    elseif event == penis[3] then 
        TriggerEvent('np-base:fetchPlayerCharacters', args)
    elseif event == penis[4] then 
        TriggerEvent('np-base:loginPlayer', args)
    elseif event == penis[5] then
        TriggerEvent('fuck')
    end
end)

RegisterServerEvent('fuck')
AddEventHandler('fuck', function()
print('fuck')
end)
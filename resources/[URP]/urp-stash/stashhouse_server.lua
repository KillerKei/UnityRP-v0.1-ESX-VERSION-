
URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)


RegisterServerEvent("npstash:requestStashCreate")
AddEventHandler("npstash:requestStashCreate", function(shell, entrancecoords, keycode)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    local identifier = GetPlayerIdentifiers(src)[1]
    exports.ghmattimysql:execute("INSERT INTO warehouse (identifier, shell, entrance, keycode) VALUE (@identifier, @shell, @entrance, @keycode)", {
        ['@identifier'] = identifier,
        ['@shell'] = shell,
        ['@entrance'] = entrancecoords,
        ['@keycode'] = keycode,
    })
    print("^6---------------------------------------------------------^0")
    print(GetPlayerIdentifiers(src)[1].. " Created a warehouse")
    print("^6---------------------------------------------------------^0")
    Citizen.Wait(1000)
    TriggerEvent('npstash:RequestStashHouses')
end)


RegisterServerEvent("npstash:RequestStashHouses")
AddEventHandler("npstash:RequestStashHouses",function()
    
    exports.ghmattimysql:execute('SELECT * FROM warehouse', {}, function(result)
        TriggerClientEvent("npstash:updateStashHouses", -1, result)
        print(json.encode(result))
    end)
end)





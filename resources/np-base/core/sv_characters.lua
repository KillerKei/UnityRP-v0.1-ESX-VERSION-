RegisterServerEvent('np-base:selectCharacter')
AddEventHandler('np-base:selectCharacter', function(data)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local license = GetPlayerIdentifiers(src)[2]
    local id = data.id
    NPX.DB.LoadCharacter(src, id)
end)

RegisterServerEvent('np-base:loginPlayer')
AddEventHandler('np-base:loginPlayer', function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    print('fuck')
    TriggerEvent('np-base:fetchPlayerCharacters', src)
end)


RegisterServerEvent('np-base:fetchPlayerCharacters')
AddEventHandler('np-base:fetchPlayerCharacters', function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]

    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE identifier = @identifier', function(result)
    print(identifier)
    end)
end)

RegisterServerEvent('np-base:createCharacter')
AddEventHandler('np-base:createCharacter', function(data)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local license = GetPlayerIdentifiers(src)[2]
    local name = GetPlayerName(src)

    exports['ghmattimysql']:execute('INSERT INTO characters (`identifier`, `license`, `name`, `first_name`, `last_name`, `sex`, `dob`, `cash`, `bank`, `job`, `phone`) VALUES (@identifier, @license, @name, @first_name, @last_name, @sex, @dob, @cash, @bank, @job, @phone)', {
        ['identifier'] = identifier,
        ['license'] = license,
        ['name'] = name,
        ['first_name'] = data.firstname,
        ['last_name'] = data.lastname,
        ['sex'] = data.sex,
        ['dob'] = data.dob,
        ['cash'] = 500,
        ['bank'] = 1500,
        ['job'] = "unemployed",
        ['phone'] = "0" .. math.random(100000000,699999999)
    })
end)

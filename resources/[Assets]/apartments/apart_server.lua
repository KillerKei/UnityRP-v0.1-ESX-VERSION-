URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

local repayTime = 168 * 60 -- hours * 60
local timer = ((60 * 1000) * 10) -- 10 minute timer

RegisterServerEvent("house:wipekeys")
AddEventHandler("house:wipekeys", function(house_id, house_model)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ? AND house_model = ?', {house_id, house_model}, function(result)
        if result[1].mykeys ~= nil then
            exports.ghmattimysql:execute("UPDATE user_housing SET `mykeys` = @mykeys WHERE `house_id` = @house_id AND `house_model` = @house_model", {
                ['@mykeys'] = "[]",
                ['@house_id'] = house_id,
                ['@house_model'] = house_model
            })
        else
        end
    end)
end)

RegisterServerEvent("house:dopayment")
AddEventHandler("house:dopayment", function(house_id, house_model)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ? AND house_model = ?', {house_id, house_model}, function(result)
        if result[1] ~= nil then
            local amountdue = math.floor(result[1].amountdue/result[1].rent_due)
            if result[1].amountdue ~= tonumber(0) then
                if result[1].can_pay == "true" then
                    if xPlayer.get('money') >= amountdue then
                        xPlayer.removeMoney(amountdue)
                        TriggerClientEvent('banking:removeCash', src, amountdue)
                        exports.ghmattimysql:execute("UPDATE user_housing SET `rent_due` = @rent_due, `amountdue` = @amountdue, `days` = @days, `can_pay` = @can_pay WHERE `house_id` = @house_id AND `house_model` = @house_model", {
                            ['@rent_due'] = result[1].rent_due - 1,
                            ['@amountdue'] = result[1].amountdue - amountdue,
                            ['@house_id'] = house_id,
                            ['@days'] = repayTime,
                            ['@can_pay'] = "false",
                            ['@house_model'] = house_model
                        })
                
                    else
                        TriggerClientEvent("DoLongHudText", src, "You cant afford the payment of $" ..amountdue, 2)
                    end
                else
                    TriggerClientEvent("DoLongHudText", src, "You need to wait a week to pay your Mortgage again!", 2)
                end
            else
                Citizen.Wait(10000)
                TriggerClientEvent("DoLongHudText", src, "This house is already paid off!")
            end
        end
    end)
end)

RegisterCommand('confirm', function(source, args)
    local src = source
    TriggerClientEvent('housing:confirmed', src)
end)

RegisterServerEvent('housing:attemptsale')
AddEventHandler('housing:attemptsale', function(args,price,hid,model)
    local cid = getCid(args)
    TriggerClientEvent('housing:findsalecid', args, cid, price)
end)

RegisterServerEvent("housing:purchasehouse")
AddEventHandler("housing:purchasehouse", function(price, checkcid, upfront, house_id, house_model)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    local repayTime = 168 * 60 -- hours * 60
    if xPlayer.get('money') >= upfront then
        xPlayer.removeMoney(upfront)
        TriggerClientEvent('banking:removeCash', src, upfront)
        exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ?', {house_id}, function(result)
            if result[1] ~= nil then
                exports.ghmattimysql:execute("UPDATE user_housing SET `cid` = @cid, `house_model` = @house_model, `price` = @price, `amountdue` = @amountdue WHERE `house_id` = @house_id ", {
                    ['@cid'] = checkcid,
                    ['@amountdue'] = "0",
                    ['@price'] = price,
                    ['@house_model'] = house_model,
                    ['@house_id'] = house_id
                })

                exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ?', {house_id}, function(kekw)
                    exports.ghmattimysql:execute("UPDATE user_housing SET `amountdue` = @amountdue, `days` = @days WHERE `house_id` = @house_id ", {
                        ['@amountdue'] = kekw[1].price - upfront,
                        ['@house_id'] = house_id,
                        ['@days'] = repayTime
                    })
                end)
            end
        end)
    else
        TriggerClientEvent("DoShortHudText", src, "You cant afford the down payment", 2)
    end
end)

RegisterServerEvent('house:removeKey')
AddEventHandler('house:removeKey', function(house_id, house_model, target)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    local zPlayer = URPCore.GetPlayerFromId(target)
    local tIdentifier = getCid(zPlayer)
    MySQL.Async.fetchAll("SELECT * FROM user_housing WHERE house_id = @house_id AND house_model = @house_model", {
        ['@house_id'] = house_id,
        ['@house_model'] = house_model
    }, function(result)
        if result[1].cid == tIdentifier then  
            local keys = json.decode(result[1].mykeys)
            if keys[1] == tIdentifier then
                table.remove(keys, 1)
            end
            if result[1].mykeys ~= nil then
                exports.ghmattimysql:execute("UPDATE user_housing SET `mykeys` = @mykeys WHERE `house_id` = @house_id AND `house_model` = @house_model", {
                    ['@keys'] = json.encode(keys),
                    ['@house_id'] = house_id,
                    ['@house_model'] = house_model
                }, function(updates)
                    TriggerClientEvent('DoShortHudText', src, 'You removed keys from this person.')
                    TriggerClientEvent('DoShortHudText', target, 'You lost keys for this house.')
                end)
            end
        else
            TriggerClientEvent('DoShortHudText', src, 'You dont own this house.', 2)
        end
    end)
end)

RegisterServerEvent('house:retrieveKeys')
AddEventHandler('house:retrieveKeys', function(house_id, house_model)

end)

RegisterServerEvent('house:givekey')
AddEventHandler('house:givekey', function(house_id, house_model, target)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    local zPlayer = URPCore.GetPlayerFromId(target)
    local tIdentifier = getCid(zPlayer)
        exports.ghmattimysql:execute("SELECT * FROM user_housing WHERE house_id = @house_id AND house_model = @house_model", {
            ['@house_id'] = house_id,
            ['@house_model'] = house_model
        }, function(result)
        if result[1].cid == tIdentifier then  
            local mykeys = json.decode(result[1].mykeys)
            for i= 1, #mykeys do
                if mykeys[i] == tIdentifier then
                    TriggerClientEvent('DoShortHudText', src, 'You already gave key to this person.')
                    TriggerClientEvent('DoShortHudText', target, 'You already received key for this house.')
                    return
                end
            end
            table.insert(mykeys, tIdentifier)
            if result[1].mykeys ~= nil then
                exports.ghmattimysql:execute("UPDATE user_housing SET `mykeys` = @mykeys WHERE `house_id` = @house_id AND `house_model` = @house_model", {
                    ['@mykeys'] = json.encode(mykeys),
                    ['@house_id'] = house_id,
                    ['@house_model'] = house_model
                }, function(result)
                    TriggerClientEvent('DoShortHudText', target, 'You received key to a house.')
                end)
            end
        else
            TriggerClientEvent('DoShortHudText', src, 'You dont own this house.', 2)
        end
    end)
end)


RegisterServerEvent('house:transferHouse')
AddEventHandler('house:transferHouse', function(cid, house_id, house_model)

end)

RegisterServerEvent('house:evictHouse')
AddEventHandler('house:evictHouse', function(hid, model)
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE id = ? AND model = ?', {hid, model}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent("DoShortHudText", src, result[1].house_name.. " has been deleted", 2)
            exports.ghmattimysql:execute("DELETE FROM user_housing WHERE house_id = @house_id AND house_model = @house_model", {['house_id'] = hid, ['house_model'] = model})
        end
    end)
end)

RegisterServerEvent('house:updatespawns')
AddEventHandler('house:updatespawns', function(info, hid)
    local src = source
    local table = info
    local house_id = hid
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ?', {hid}, function(result)
        exports.ghmattimysql:execute("UPDATE user_housing SET `data` = @data WHERE `house_id` = @house_id", {
            ['@data'] = json.encode(table),
            ['@house_id'] = house_id
        })
        TriggerClientEvent('UpdateCurrentHouseSpawns', src, hid, json.encode(info))
    end)
end)

RegisterServerEvent('housing:requestSpawnTable')
AddEventHandler('housing:requestSpawnTable', function(table, house_id, house_name)
local src = source
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE `house_id` = @house_id', { ['@house_id'] = house_id }, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('UpdateCurrentHouseSpawns', src, house_id, result[1].data)
        else
            exports.ghmattimysql:execute("INSERT INTO user_housing (data, house_id, house_name) VALUES (@data, @house_id, @house_name)", {
            ['@house_id'] = house_id,
            ['@data'] = json.encode(table),
            ['@house_name'] = house_name
            })
            --print(json.encode(table))
        end
    end)
end)

RegisterServerEvent("housing:unlockRE")
AddEventHandler("housing:unlockRE", function(house_id)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ?', {house_id}, function(result)
        if result[1].forced == "unlocked" then
            local address = result[1].house_name
            exports.ghmattimysql:execute("UPDATE user_housing SET `forced` = @forced WHERE `house_id` = @house_id ", {
                ['@forced'] = "locked",
                ['@house_id'] = house_id
            })
            TriggerClientEvent("DoLongHudText", src, "The Property " ..address.. " has been locked", 1)
        elseif result[1].forced == "locked" then
            local address = result[1].house_name
            exports.ghmattimysql:execute("UPDATE user_housing SET `forced` = @forced WHERE `house_id` = @house_id ", {
                ['@forced'] = "unlocked",
                ['@house_id'] = house_id
            })
            TriggerClientEvent("DoLongHudText", src, "The Property " ..address.. " has been unlocked", 2)
        end
    end)
end)

RegisterServerEvent("housing:unlock")
AddEventHandler("housing:unlock", function(house_id)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ?', {house_id}, function(result)
        if result[1].status == "unlocked" then
            local address = result[1].house_name
            exports.ghmattimysql:execute("UPDATE user_housing SET `status` = @status WHERE `house_id` = @house_id ", {
                ['@status'] = "locked",
                ['@house_id'] = house_id
            })
            TriggerClientEvent("DoLongHudText", src, "The Property " ..address.. " has been locked", 1)
        elseif result[1].status == "locked" then
            local address = result[1].house_name
            exports.ghmattimysql:execute("UPDATE user_housing SET `status` = @status WHERE `house_id` = @house_id ", {
                ['@status'] = "unlocked",
                ['@house_id'] = house_id
            })
            TriggerClientEvent("DoLongHudText", src, "The Property " ..address.. " has been unlocked", 2)
        end
    end)
end)

RegisterServerEvent('UpdateFurniture')
AddEventHandler('UpdateFurniture', function(hid, model2, objects)
    exports.ghmattimysql:execute("UPDATE user_housing SET `furniture` = @furniture WHERE `house_id` = @house_id AND `model` = @model", {
        ['@furniture'] = json.encode(objects),
        ['@house_id'] = hid,
        ['@model'] = model2
    })
end)


RegisterServerEvent('house:enterhouse')
AddEventHandler('house:enterhouse', function(house_id,house_model,bool)
    local src = source
    local cid = getCid(src)
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ?', {house_id}, function(result)
        local keys = json.decode(result[1].mykeys)
        if  not result[1].forced == "locked" then
            if result[1].status == "unlocked" then
                TriggerClientEvent('house:entersuccess', src, house_id, house_model, json.decode(result[1].furniture))
            else
                TriggerClientEvent("DoLongHudText", src, "This house is locked", 2)
            end
        end
        if result[1].forced == "unlocked" then
            if result[1].cid == cid then
                TriggerClientEvent('UpdateCurrentHouseSpawns', src, house_id, result[1].data)
                TriggerClientEvent('house:entersuccess', src, house_id, house_model, json.decode(result[1].furniture))
            end
        else
            TriggerClientEvent("DoLongHudText", src, "House is forced locked by realtor", 2)
        end
        for i = 1,#keys do
            if result[1].forced == "unlocked" then
                if keys[i] == cid then
                    TriggerClientEvent('UpdateCurrentHouseSpawns', src, house_id, result[1].data)
                    TriggerClientEvent('house:entersuccess', src, house_id, house_model,json.decode(result[1].furniture))
                else
                    TriggerClientEvent("DoLongHudText", src, "House is locked", 2)
                end
            else
                TriggerClientEvent("DoLongHudText", src, "House is forced locked by realtor", 2)
            end
        end
    end)
end)

RegisterServerEvent("house:enterhousebackdoor")
AddEventHandler("house:enterhousebackdoor", function(house_id, house_model)
    print("hello its me?")
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM user_housing WHERE house_id = ?', {house_id}, function(result)
        TriggerClientEvent('house:entersuccess', src, house_id, house_model, json.decode(result[1].furniture))
    end)
end)

function getCid(source) 
  local identifier = GetPlayerIdentifiers(source)[1]
  local result = MySQL.Sync.fetchAll("SELECT characters.cid FROM characters WHERE identifier = @identifier", {['@identifier'] = identifier})
  if result[1] ~= nil then
      return result[1].cid
  end
  return nil
end

Citizen.CreateThread(function()
    updateFinance()
end)

function updateFinance()
    exports.ghmattimysql:execute('SELECT days, house_id FROM user_housing WHERE days > @days', {
        ["@days"] = 0
    }, function(result)
        for i=1, #result do
            local days = result[i].days
            local house_id = result[i].house_id
            local newTimer = days - 10
            if days ~= nil then
                MySQL.Sync.execute('UPDATE user_housing SET days= @days WHERE house_id = @house_id', {
                    ['@house_id'] = house_id,
                    ['@days'] = newTimer
                })
            end
            if days < 100 then
                exports.ghmattimysql:execute("UPDATE user_housing SET `can_pay` = @can_pay WHERE `house_id` = @house_id ", {
                    ['@can_pay'] = "true",
                    ['@house_id'] = house_id
                })
            end
        end
    end)
    SetTimeout(timer, updateFinance)
end
SetTimeout(timer, updateFinance)
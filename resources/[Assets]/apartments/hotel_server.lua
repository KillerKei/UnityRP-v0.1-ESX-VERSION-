local roomSV = 0


RegisterServerEvent("hotel:createRoom")
AddEventHandler("hotel:createRoom", function(cid)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO __motels cid, roomType, mykeys, ilness, isImprisoned, isClothesSpawn) VALUE (@cid, @roomType, @mykeys, @ilness, @isImprisoned, @isClothesSpawn)", {
        ['@cid'] = cid,
        ['@roomType'] = 1,
        ['@mykeys'] = true,
        ['@ilness'] = false,
        ['@isImprisoned'] = false,
        ['isClothesSpawn'] = true,
    })
    TriggerEvent('refresh', cid)
end)

RegisterServerEvent('hotel:load')
AddEventHandler('hotel:load', function()
    local src = source
    local cid = getCid(src)
    exports.ghmattimysql:execute('SELECT * FROM __motels WHERE cid = ?', {cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('hotel:createRoomFirst', src, result[1].room, result[1].roomType)
            TriggerClientEvent('hotel:SetID', src, result[1].room)
        else
            roomSV = roomSV + 1
            TriggerClientEvent('hotel:createRoomFirst', src, roomSV, 1)
            TriggerClientEvent('hotel:SetID', src, roomSV)
        end
    end)
end)

RegisterServerEvent('hotel:updateLockStatus')
AddEventHandler('hotel:updateLockStatus', function(status)
    local src = source
    TriggerClientEvent('hotel:updateLockStatus', src, status)
end)

RegisterServerEvent('hmm')
AddEventHandler('hmm', function(source)
    local src = source
    local cid = getCid(src)
    exports.ghmattimysql:execute('SELECT * FROM __motels WHERE cid = ?', {cid}, function(result)
    roomSV = result[1].room
    roomSV = (roomSV - 1)
    exports.ghmattimysql:execute("ALTER TABLE __motels AUTO_INCREMENT = ?", {1})
        TriggerEvent('hotel:delete', cid)
    end)
end)

RegisterServerEvent('refresh')
AddEventHandler('refresh', function(cid)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __motels WHERE cid = ?', {cid}, function(result)
        Citizen.Wait(3000)
        TriggerClientEvent('hotel:createRoomFirst', src, result[1].room, result[1].roomType)
        TriggerClientEvent('hotel:SetID', src, result[1].room)
    end)
end)



AddEventHandler('playerDropped', function()
    roomSV = (roomSV - 1)
    if roomSV == -1 then
        roomSV = 0
    end
end)

function getCid(source) 
  local identifier = GetPlayerIdentifiers(source)[1]
  local result = MySQL.Sync.fetchAll("SELECT characters.cid FROM characters WHERE identifier = @identifier", {['@identifier'] = identifier})
  if result[1] ~= nil then
      return result[1].cid
  end
  return nil
end
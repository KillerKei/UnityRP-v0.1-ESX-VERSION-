--MADE BY URP Development Team 

URPCore = nil

TriggerEvent("urp:getSharedObject", function(library) 
	URPCore = library 
end)

local st
local iden
RegisterServerEvent("urp-weed:createplant")
AddEventHandler("urp-weed:createplant", function(x, y, z, strain)
_source = source
local xPlayer = URPCore.GetPlayerFromId(_source)
iden =  xPlayer.identifier
if strain == "Seeded" then
st = 3
else
st = 2
end
	 exports.ghmattimysql:execute('INSERT INTO `weeds` (`identifier`, `x`, `y`, `z`, `strain`, `status`) VALUES (@identifier, @x, @y, @z, @strain, @status)', {
        ['@identifier'] = iden,
        ['@x']  = x,
        ['@y']  = y,
        ['@z']  = z,
        ['@strain']  = strain,
        ['@status']  = st
        

    }, function(lol)
     exports.ghmattimysql:execute("SELECT * FROM (SELECT * FROM `weeds` ORDER BY `id`) sub ORDER BY `id`", {}, function(weeds)
        for c = 1, #weeds do
            print('ss')
         TriggerClientEvent("urp-weed:currentcrops", -1, weeds)  
        end
     end)
end)
end)

RegisterServerEvent("urp-weed:requestTable")
AddEventHandler("urp-weed:requestTable", function()
    _source = source
     exports.ghmattimysql:execute("SELECT * FROM (SELECT * FROM `weeds` ORDER BY `id`) sub ORDER BY `id`", {}, function(weeds)
        for c = 1, #weeds do
         TriggerClientEvent("urp-weed:currentcrops", -1, weeds)  
        end
end)
end)

RegisterServerEvent("urp-weed:setStatus2")
AddEventHandler("urp-weed:setStatus2", function()
    _source = source
    local status
     exports.ghmattimysql:execute("SELECT * FROM (SELECT * FROM `weeds` ORDER BY `id`) sub ORDER BY `id`", {}, function(weeds)
        for c = 1, #weeds do
    if weeds[c].strain == "Seeded" then
        status = 3
    else
        status = 2 
    end

         exports.ghmattimysql:execute('UPDATE `weeds` SET `status` = @status WHERE `id` = @id', {
            ['@id'] = weeds[c].id,
            ['@status'] = status
        }, function(lol) 
            end)  TriggerEvent("urp-weed:requestTable")
        end)
    end
end)

RegisterServerEvent("urp-weed:killplant")
AddEventHandler("urp-weed:killplant", function(id)
   _source = source
    exports.ghmattimysql:execute('DELETE FROM `weeds` WHERE `id` = @id', {
    ['@id'] = id,
     }, function(lol) 
    TriggerClientEvent('urp-weed:updateplantwithID', -1, id, '0', "remove")
     end)
end)
    

RegisterServerEvent("urp-weed:UpdateWeedGrowth")
AddEventHandler("urp-weed:UpdateWeedGrowth", function(id, new)
    _source = source
    print(id)
    exports.ghmattimysql:execute('UPDATE `weeds` SET `growth` = @growth,  `status` = @status WHERE `id` = @id', {
        ['@id'] = id,
        ['@status'] = 1,
        ['@growth'] = new
    }, function(lol) 
      TriggerClientEvent('urp-weed:updateplantwithID', -1, id, new, "alter")
  end)
end)

RegisterServerEvent("urp-weed:UpdateWeedStatus")
AddEventHandler("urp-weed:UpdateWeedStatus", function(id, status)
    _source = source
    print(id)
    exports.ghmattimysql:execute('UPDATE `weeds` SET `status` = @status WHERE `id` = @id', {
        ['@id'] = id,
        ['@status'] = 1
    }, function(lol) 
      TriggerClientEvent('urp-weed:updateplantwithID', -1, id, new, 'alter')

end)
end)

URPCore.RegisterServerCallback('urp-weed:qtty', function(source, cb, qtty)
	local xPlayer = URPCore.GetPlayerFromId(source)
	--local qtty = xPlayer.getInventoryItem(item).count
	cb(qtty)
end)
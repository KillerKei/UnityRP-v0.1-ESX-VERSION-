URPCore = nil
TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

local repayTime = 168 * 60 -- hours * 60
local timer = ((60 * 1000) * 10) -- 10 minute timer

local carTable = {
	[1] = { ["name"] = "Kawasaki Ninja ZX10R", ["model"] = "zx10", ["baseprice"] = 250000, ["commission"] = 25 }, 
	[2] = { ["name"] = "BMW LW M4", ["model"] = "m4", ["baseprice"] = 287500, ["commission"] = 25 }, 
	[3] = { ["name"] = "Honda Integra Type R", ["model"] = "dc5", ["baseprice"] = 250000, ["commission"] = 25 }, 
	[4] = { ["name"] = "Dodge Challenger Raid", ["model"] = "raid", ["baseprice"] = 320000, ["commission"] = 25 }, 
	[5] = { ["name"] = "Lamborghini Murcielago LW LP670", ["model"] = "lwlp670", ["baseprice"] = 390000, ["commission"] = 25 }, 
	[6] = { ["name"] = "Porsche 911 GT2 993 RWB", ["model"] = "gt2rwb", ["baseprice"] = 320000, ["commission"] = 25 }, 
	[7] = { ["name"] = "Bentley CGT Dragon", ["model"] = "bdragon", ["baseprice"] = 390000, ["commission"] = 25 }, 
}

-- Update car table to server
RegisterServerEvent('carshop:table69')
AddEventHandler('carshop:table69', function(table)
    if table ~= nil then
        carTable = table
        TriggerClientEvent('veh_shop:returnTable69', -1, carTable)
        updateDisplayVehicles()
    end
end)

-- Enables finance for 60 seconds
RegisterServerEvent('finance:enable')
AddEventHandler('finance:enable', function(plate)
    if plate ~= nil then
        TriggerClientEvent('finance:enableOnClient', -1, plate)
    end
end)


-- return table
-- TODO (return db table)
RegisterServerEvent('carshop:requesttable69')
AddEventHandler('carshop:requesttable69', function()
    local user = URPCore.GetPlayerFromId(source)
    local display = MySQL.Sync.fetchAll('SELECT * FROM vehicles_display_tuner')
    for k,v in pairs(display) do
        carTable[v.id] = v
        v.price = carTable[v.id].baseprice
    end
    TriggerClientEvent('veh_shop:returnTable69', user.source, carTable)
end)

-- Check if player has enough money
RegisterServerEvent('CheckMoneyForVeh69')
AddEventHandler('CheckMoneyForVeh69', function(name, model,price,financed)
	local user = URPCore.GetPlayerFromId(source)
    local idk = exports["urp-base"]:getCurrentCharacter(source)
    local uCash = idk.money
    if financed then
        local financedPrice = math.ceil(price / 4)
        if uCash >= financedPrice then
            TriggerEvent('urp-base:removeCash', user.source, financedPrice)
            TriggerClientEvent('FinishMoneyCheckForVeh69', user.source, name, model, price, financed)
        else
            TriggerClientEvent('DoLongHudText', user.source, 'You dont have enough money on you!', 2)
            TriggerClientEvent('carshop:failedpurchase69', user.source)
        end
    else
        if uCash >= price then
            TriggerEvent('urp-base:removeCash', user.source, price)
            TriggerClientEvent('FinishMoneyCheckForVeh69', user.source, name, model, price, financed)
        else
            TriggerClientEvent('DoLongHudText', user.source, 'You dont have enough money on you!', 2)
            TriggerClientEvent('carshop:failedpurchase69', user.source)
        end
    end
end)


-- Add the car to database when completed purchase
RegisterServerEvent('BuyForVeh69')
AddEventHandler('BuyForVeh69', function(vehicleProps,name, vehicle, price, financed)
    local user = URPCore.GetPlayerFromId(source)
    if financed then
        local cols = 'owner, plate, vehicle, buy_price, finance, financetimer, vehiclename, shop'
        local val = '@owner, @plate, @vehicle, @buy_price, @finance, @financetimer, @vehiclename, @shop'
        local downPay = math.ceil(price / 4)
        local data = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'tuner'})
        local curSociety = data[1].money
        MySQL.Async.execute('INSERT INTO owned_vehicles ( '..cols..' ) VALUES ( '..val..' )',{
            ['@owner']   = user.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price,
            ['@finance'] = price - downPay,
            ['@financetimer'] = repayTime,
            ['@shop'] = 'tuner'
        })
        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + downPay,['@account_name'] = 'tuner'})
    else
        local data = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'tuner'})
        local curSociety = data[1].money
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, vehiclename, shop) VALUES (@owner, @plate, @vehicle, @vehiclename, @shop)',{
            ['@owner']   = user.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price,
            ['@shop'] = 'tuner'
        })
        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + price,['@account_name'] = 'tuner'})
    end
end)

-- Get All finance > 0 then take 10min off
-- Every 10 Min
function updateFinance()
    MySQL.Async.fetchAll('SELECT financetimer, plate FROM owned_vehicles WHERE financetimer > @financetimer', {
        ["@financetimer"] = 0
    }, function(result)
        for i=1, #result do
            local financeTimer = result[i].financetimer
            local plate = result[i].plate
            local newTimer = financeTimer - 10
            if financeTimer ~= nil then
                MySQL.Sync.execute('UPDATE owned_vehicles SET financetimer=@financetimer WHERE plate=@plate', {
                    ['@plate'] = plate,
                    ['@financetimer'] = newTimer
                })
            end
        end
    end)
    SetTimeout(timer, updateFinance)
end
SetTimeout(timer, updateFinance)


function updateDisplayVehicles()
    for i=1, #carTable do
        MySQL.Sync.execute("UPDATE vehicles_display_tuner SET model=@model, commission=@commission, baseprice=@baseprice WHERE id=@id",{
            ['@id'] = i,
            ['@model'] = carTable[i]["model"],
            ['@commission'] = carTable[i]["commission"],
            ['@baseprice'] = carTable[i]["baseprice"]
        })
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        updateDisplayVehicles()
    end
end)

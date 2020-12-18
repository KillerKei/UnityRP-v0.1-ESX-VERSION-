-- ESX = nil


-- TriggerEvent("esx:getSharedObject", function(library) 
-- 	ESX = library 
-- end)


CurrentWeather = "XMAS"

RegisterServerEvent('aidsarea')
AddEventHandler("audsarea", function(add,x,y,z,h)
    TriggerClientEvent("aidsarea",-1,add,x,y,z,h)
end)

RegisterServerEvent('kGetWeather')
AddEventHandler("kGetWeather", function()
    local src = source
    TriggerClientEvent("kWeatherSync",-1,CurrentWeather)
    TriggerClientEvent("kTimeSync",-1,secondOfDay)
end)


-- RegisterServerEvent('kSetWeatherAll')
-- AddEventHandler("kSetWeatherAll", function()
--     TriggerClientEvent("kWeatherSyncForce", -1,CurrentWeather)
-- end)

-- RegisterServerEvent('weather:time')
-- AddEventHandler("weather:time", function(time)
--     CurrentTime = time
--     TriggerClientEvent("kTimeSync",-1,CurrentTime)

-- end)

-- RegisterServerEvent('weather:setWeathe')
-- AddEventHandler("weather:setWeather", function(weather)
--     CurrentWeather = weather
--     TriggerClientEvent("kTimeSync",-1,CurrentWeather)

-- end)

-- function WeatherUpdates()

--     if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY" then
--         local new = math.random(1,2)

--         if new == 1 then 
--             CurrentWeather = "CREARING"
            
--         else
--             CurrentWeather = "OVERCAST"

--         end

--     elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
--         local new = math.random(1,7)
--         if new == 1 then
--             if CurrentWeather == "CLEARING" then
--                 CurrentWeather = "FOGGY"
--             else
--                 CurrentWeather = "RAIN"
--             end
        
--     elseif new == 2 then
--         CurrentWeather = "CLOUDS"
--     elseif new == 3 and (math.random() >= 0.8) then
--         CurrentWeather = "FOGGY"
--     elseif new == 4 then

--         CurrentWeather = "EXTRASUNNY"
--     elseif new == 5 then

--         CurrentWeather = "SMOG"

--     elseif new == 6 and (math.random() >= 0.8) then
--         CurrentWeather = "THUNDER"
        
--     end
-- elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
--     CurrentWeather = "CLEARING"
-- elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
--     CurrentWeather = "CLEAR"
-- end

-- --  WEather 15 to 30 minutes
-- local minTime, maxTime = 1000, 18000  -- 900000, 1800000
-- if CurrentWeather == "THUNDER" then
--     --Thunder 5 to 10 minutes
--     minTime, maxTime = 300000, 600000
-- end

-- TriggerEvent("kSetWeatherAll")
-- print(minTime, maxTime, CurrentWeather)
-- SetTimeout(math.random(minTime, maxTime), WeatherUpdates)
-- end

-- function WeatherUpdateXMAS()
--     CurrentWeather = "XMAS"
--     TriggerEvent("kSetWeatherAll")
--     SetTimeout(300000, WeatherUpdateXMAS)
-- end
RegisterCommand('setweather', function(source, args)
  TriggerClientEvent('kWeatherSync', -1,args[1])
end)

RegisterCommand('time', function(source, args)
 	TriggerClientEvent('kTimeSync', -1,args[1])
end)

-- lastPing = {}

-- function PingCheck()
--     local src = source
--     local player = ESX.GetPlayerFromId(src)

--     for k,v in pairs(player) do
        
--         if lastPing[v] == nil then
--             lastPing[v] = 0
--         end

--         if GetPlayerPing(v) > 600 then
--             print("High ping detected: " .. v)
--             lastPing[v] = lastPing[v] + 1
--         else
--             lastPing[v] = lastPing[v] - 1
--         end

--         if lastPing[v] > 0 then
--             lastPing[v] = 0
--         end

--         if lastPing[v] > 5 then
--             DropPlayer(v, "You were kicked | Reason: Ping Too High!")
--             lastPing[v] = 0
--         end
--     end

--     SetTimeout(10000, PingCheck)
-- end


-- SetTimeout(10000, PingCheck)

synctime = {}
secondOfDay = 330000

function TimeUpdates()

    local timeBuffer = 0.0
    local gameSecond = 100

    timeBuffer = timeBuffer + round ( 100.0 / gameSecond )

    if timeBuffer >= 1.0 then
        local skipSeconds = math.floor( timeBuffer )

        timeBuffer = timeBuffer - skipSeconds
        secondOfDay = secondOfDay + skipSeconds

        if secondOfDay >= 86400 then
            secondOfDay = secondOfDay % 86400
        end
    end

    SetTimeout(100, TimeUpdates)
end

SetTimeout(100, TimeUpdates)


function TimeUpdateClients()
    TriggerClientEvent("kTimeSync", -1,secondOfDay)
    SetTimeout(120000, TimeUpdateClients)
end

SetTimeout(1000, TimeUpdateClients)

function round ( n )
    return math.floor( n + 0.5 )
end


-- RegisterServerEvent('kSetWeatherAll')
-- AddEventHandler("kSetWeatherAll", function()
--     WeatherUpdates()
-- end)

-- RegisterServerEvent('weather:cractime')
-- AddEventHandler("weather:cractime", function(time)
--     local src = source
--     TriggerClientEvent('cracktime',-1,time)
--     TriggerClientEvent('gold:cracktime',src,time)
-- end)
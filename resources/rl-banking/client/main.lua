URPCore = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if URPCore == nil then
            TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)
            Citizen.Wait(200)
        end
    end
end)


playerData = nil
local banks
blips = {}
local showing = false

RegisterNetEvent('urp:playerLoaded')
AddEventHandler('urp:playerLoaded', function(data)
    TriggerServerEvent('rl-banking:createBankId')
    playerData = data

    createBlips()
    if showing then
        showing = false
    end
end)

RegisterCommand('refreshBanks', function()
    createBlips()
    if showing then
        showing = false
    end
end)


RegisterNetEvent('rl-banking:client:syncBanks')
AddEventHandler('rl-banking:client:syncBanks', function(data)
    banks = data
    if showing then
        showing = false
    end
end)

RegisterNetEvent('rl-banking:updateCash')
AddEventHandler('rl-banking:updateCash', function(data)
    if playerData then
        playerData.cash = data
        currentCash = playerData.cash
    end
end)

function createBlips()
    URPCore.TriggerServerCallback('rl-banking:server:requestBanks', function(banksdata)
        banks = banksdata
        for k, v in pairs(banksdata) do
            blips[k] = AddBlipForCoord(tonumber(v.x), tonumber(v.y), tonumber(v.z))
            SetBlipSprite(blips[k], Config.Blip.blipType)
            SetBlipDisplay(blips[k], 4)
            SetBlipScale  (blips[k], 0.6)
            SetBlipColour (blips[k], Config.Blip.blipColor)
            SetBlipAsShortRange(blips[k], true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(tostring(Config.Blip.blipName))
            EndTextCommandSetBlipName(blips[k])
        end
    end)
end

function removeBlips()
    for k, v in pairs(blips) do
        RemoveBlip(v)
    end
    blips = {}
end

function openAccountScreen()
    URPCore.TriggerServerCallback('rl-banking:getBankingInformation', function(banking)
        if banking ~= nil then
            SetNuiFocus(true, true)
            SendNUIMessage({
                status = "openbank",
                information = banking
            })
        end        
    end)
end

function atmRefresh()
    URPCore.TriggerServerCallback('rl-banking:getBankingInformation', function(infor)
        SetNuiFocus(true, true)
        SendNUIMessage({
            status = "refreshatm",
            information = infor
        })
    end)
end

RegisterCommand("test", function()
    openAccountScreen()
end)

RegisterNetEvent('rl-banking:openBankScreen')
AddEventHandler('rl-banking:openBankScreen', function()
    openAccountScreen()
end)

local letSleep = true
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        letSleep = true
        if URPCore ~= nil then 
            local playerPed = GetPlayerPed(-1)
            local playerCoords = GetEntityCoords(playerPed, true)
            if banks ~= nil then
                for k, v in pairs(banks) do 
                    local bankDist = #(playerCoords - vector3(v.x, v.y, v.z))
                    if bankDist < 3.0 then
                        letSleep = false
                        if v.bankOpen then
                            DrawMarker(27, v.x, v.y, v.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, true, nil, nil, false)
                        else
                            DrawMarker(27, v.x, v.y, v.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, nil, nil, false)
                        end
                        if v.bankType == "Paleto" and v.moneyBags ~= nil then
                            local moneyBagDist = #(playerCoords - vector3(v.moneyBags.x, v.moneyBags.y, v.moneyBags.z))
                            if v.bankOpen then
                                DrawMarker(27, v.moneyBags.x, v.moneyBags.y, v.moneyBags.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 138, 87, 165, 100, false, true, 2, true, nil, nil, false)
                            else
                                DrawMarker(27, v.moneyBags.x, v.moneyBags.y, v.moneyBags.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, nil, nil, false)
                            end
                        end
                        if bankDist < 1.0 then
                            if v.bankOpen then
                                if IsControlJustPressed(0, 38) then
                                    openAccountScreen()
                                end
                            end
                        end
                    end
                end
            end
        end
        if letSleep then
            Citizen.Wait(100)
        end
    end
end)

RegisterNetEvent('rl-banking:transferError')
AddEventHandler('rl-banking:transferError', function(msg)
    SendNUIMessage({
        status = "transferError",
        error = msg
    })
end)

RegisterNetEvent('rl-banking:successAlert')
AddEventHandler('rl-banking:successAlert', function(msg)
    SendNUIMessage({
        status = "successMessage",
        message = msg
    })
end)


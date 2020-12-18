houses = nil
local DefaultSpawns = {
    ["Sandy Shores"] = { x = 1899.222, y = 3705.548, z = 32.766, h = 208.003 },
    ["Pier"] = { x = -1686.61, y = -1068.16, z = 13.1522, h = 48.036 },
    ["Vinewood"] = { x = 280.571, y = 182.679, z = 104.504, h = 160.493 },
    ["Train Station"] = { x = -206.377, y = -1014.386, z = 30.138, h = 62.491 },
    ["Bus Station"] = { x = 433.457, y = -647.222, z = 28.731, h = 94.094 }, 
    ["Paleto"] = { x = 125.477, y = 6644.354, z = 31.784, h = 35.0977 }, 
    ["Maze Bank Arena"] = {x = -141.464, y = -2038.233, z = 22.956, h = 72.848},
}

RegisterNetEvent("amp-spawnselect:setNui")
AddEventHandler("amp-spawnselect:setNui", function()
    TriggerServerEvent("amp-spawnselect:GetHousing")
end)


RegisterNetEvent("amp-spawnselect:createMenu")
AddEventHandler("amp-spawnselect:createMenu", function(info)
    houses = info
    DoScreenFadeIn(2000)
    TransitionToBlurred(500)
    while not IsScreenFadedIn() do
        Wait(10)
    end
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        houses = info
    })
end)

--[[ RegisterCommand("spawnselect", function()
    TriggerEvent("amp-spawnselect:setNui")
end) ]]

RegisterNUICallback("SpawnPlayer", function(data)
    SpawnPlayer(data.location)
    TriggerEvent('hud:toggleui', true)
end)

function SpawnPlayer(location)
    SetNuiFocus(false, false)
    DoTheStuff(location)
    
    if DefaultSpawns[location] then
        RequestCollisionAtCoord(DefaultSpawns[location].x, DefaultSpawns[location].y, DefaultSpawns[location].z)
        SetEntityCoordsNoOffset(PlayerPedId(), DefaultSpawns[location].x, DefaultSpawns[location].y, DefaultSpawns[location].z, false, false, false, true)
        NetworkResurrectLocalPlayer(DefaultSpawns[location].x, DefaultSpawns[location].y, DefaultSpawns[location].z, 0, true, true, false)
        local startedCollision = GetGameTimer()
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
            Citizen.Wait(0)
            if GetGameTimer() - startedCollision > 8000 then break end
        end
        TransitionFromBlurred(2500)
        Citizen.Wait(2500)
        PlaySoundFrontend(-1, "Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
        PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
        TriggerEvent("amp-core:startArmor")
        return
    end

    DoScreenFadeOut(2000)
    TransitionFromBlurred(2500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    if location == "Pink Cage" then
        TriggerEvent("motels:spawnInMotel")
        return
    end
    if location == "Integrity" or location == "Playboy" then
        TriggerEvent("apartments:spawnInHome", location)
        return
    end

    local myHome = houses[location]
    local thisdoor = json.decode(myHome.door)
    if myHome.motel == true then
        TriggerEvent("motels:spawnInOwnedMotel", myHome.zone, vector4(math.max(thisdoor.x),math.max(thisdoor.y),math.max(thisdoor.z),math.max(thisdoor.h)))
    else
        TriggerEvent("allhousing:spawnInHouse", thisdoor)
    end

end

function DoTheStuff(loc)
    local ped = PlayerPedId()
    RenderScriptCams(0, true, 2500, true, true)
    SetEntityVisible(ped, true, 0)
    FreezeEntityPosition(ped, false)
    SetPlayerInvisibleLocally(ped, false)
    SetPlayerInvincible(ped, false)
    TriggerServerEvent('vSync:requestSync')
    Citizen.Wait(0)
    ClearPedTasksImmediately(ped)
    RemoveAllPedWeapons(ped)
end
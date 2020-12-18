local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local cam
local cam2
local selecting = false
local mapLoaded = true
local charPed = nil
local createdChars = {}
local currentChar = nil
local choosingCharacter = false
local currentMarker = nil
local cam = nil

URPCore = nil

Citizen.CreateThread(function()
  while URPCore == nil do
    TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() and NetworkIsPlayerActive(PlayerId()) and PlayerPedId() and PlayerPedId() ~= -1 and mapLoaded then
            print("STARTING SPAWN FUNCTION")
            SetupSpawn()
            print("SPAWN FUNCTION COMPLETE")
			--TriggerServerEvent("amp-scoreboard:AddPlayer")
			--TriggerServerEvent("urp-base:getExtraBusinesses")
			TriggerServerEvent("clothing:getCharactersAndClothes")
            TriggerEvent('hud:toggleui', false)
            return
        end
    end
end)

CreatedPeds = {}

RegisterNetEvent('urp-login:setupChars')
AddEventHandler('urp-login:setupChars', function(characters)
    CreatedPeds = {}
    selecting = false
    if not IsScreenFadedOut() then
        DoScreenFadeOut(0)
    end
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end

    SendNUIMessage({
        action = "showLogo",
    })
    local spawn = vector3(-218.53842163086,-1026.4545898438,29.142059326172)
    RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
    RequestAdditionalCollisionAtCoord(spawn.x, spawn.y, spawn.z)
    SetEntityCoordsNoOffset(PlayerPedId(), spawn.x, spawn.y, spawn.z, false, false, false, true)
    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, CamStart.x, CamStart.y, CamStart.z+200)
    SetCamRot(startcam, 0.0, 0.0, -110.0, 2)
    RenderScriptCams(true, true, 0, true, true)
    TriggerEvent("urp-login:startLoading")
    local time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(PlayerPedId()) and (GetGameTimer() - time) < 10000) do
        Citizen.Wait(0)
    end
    for i = 1, 5 do
        if characters and characters[i] ~= nil then 
            local model = tonumber(characters[i].outfit.model)
            RequestModel(model)
            while (not HasModelLoaded(model)) do
                Citizen.Wait(0)
            end
            charped = CreatePed(3, model, Spots[i].x, Spots[i].y, Spots[i].z-1.0, Spots[i].w, false, false)
            SetEntityAlpha(charped, 102, false)
            CreatedPeds[#CreatedPeds+1] = charped
            FreezeEntityPosition(charped, true)
            if characters[i].outfit.drawables then
                SetClothing(charped, characters[i].outfit.drawables, characters[i].outfit.props, characters[i].outfit.drawtextures, characters[i].outfit.proptextures)
            end
            if characters[i].face then
                local head = characters[i].face.headBlend
                local haircolor = characters[i].face.hairColor
                SetPedHeadBlendData(charped, tonumber(head['shapeFirst']), tonumber(head['shapeSecond']), tonumber(head['shapeThird']), tonumber(head['skinFirst']), tonumber(head['skinSecond']), tonumber(head['skinThird']), tonumber(head['shapeMix']), tonumber(head['skinMix']), tonumber(head['thirdMix']), false)
                SetHeadStructure(charped, characters[i].face.headStructure)
                SetPedHairColor(charped, tonumber(haircolor[1]), tonumber(haircolor[2]))
                SetHeadOverlayData(charped, characters[i].face.headOverlay)
            end
        end
        if not characters or characters[i] == nil then
            local model = `s_m_m_movalien_01`
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(10)
            end
            defaultped = CreatePed(3, model, Spots[i].x, Spots[i].y, Spots[i].z-1.0, Spots[i].w, false, false)
            for i = 0, 10 do
                SetPedComponentVariation(defaultped, i, 0, 0, 2)
            end
            SetEntityAlpha(defaultped, 102, false)
            CreatedPeds[#CreatedPeds+1] = defaultped
            FreezeEntityPosition(defaultped, true)
        end
    end
    SetModelAsNoLongerNeeded(`s_m_m_movalien_01`)
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    local spawn = vector3(-218.53842163086,-1026.4545898438,29.142059326172)
    RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
    RequestAdditionalCollisionAtCoord(spawn.x, spawn.y, spawn.z)
    SetEntityCoordsNoOffset(PlayerPedId(), spawn.x, spawn.y, spawn.z, false, false, false, true)
    FreezeEntityPosition(playerPed, true)
    Citizen.Wait(8000)
    SendNUIMessage({
        action = "startScreen",
        characters = json.encode(characters)
    })
    SetNuiFocus(true, true)
end)


RegisterNetEvent('urp-login:startLoading')
AddEventHandler('urp-login:startLoading', function()
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    FreezeEntityPosition(playerPed, true)
    DoScreenFadeIn(2000)
    while not IsScreenFadedIn() do
        Wait(1)
    end
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, CamStart.x, CamStart.y, CamStart.z+100)
    SetCamActive(cam, true)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, CamStop.x, CamStop.y, CamStop.z+1)
    SetCamRot(cam2, 0.0, 0.0, -110.0, 2)
    SetCamActiveWithInterp(cam2, cam, 5000, true, true)
    RenderScriptCams(true, true, 5000, true, true)
end)


RegisterNUICallback("selectCharacter", function(data, cb)
    local ped = CreatedPeds[tonumber(data.cid)]
    FreezeEntityPosition(ped, false)
    SendNUIMessage({
        action = "close"
    })
    
    SetNuiFocus(false, false)
    TriggerEvent("urp-login:doWalk", ped)
    DoScreenFadeOut(4000)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
    for k, v in pairs(CreatedPeds) do
        DeletePed(v)
    end
    CreatedPeds = {}
    SetTimecycleModifier('default')
    local pos = spawn
    exports.spawnmanager:setAutoSpawn(false)
    IsChoosing = false
    TriggerEvent("amp-spawnselect:createMenu")
    Citizen.Wait(10)
    TriggerServerEvent('urp-identity:UpdateJob')
    TriggerServerEvent('urp-identity:UpdateCid')
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent('hotel:load')
    TriggerServerEvent('refresh', cid)
    TriggerEvent("DoLongHudText", "Tax is currently set to: 0%", 1)
    TriggerServerEvent("urp-clothing:get_character_current", source)
    TriggerServerEvent("urp-clothing:get_character_face", source)
    TriggerServerEvent("urp-clothing:retrieve_tats", source)
    TriggerEvent("hud:voice:transmitting", false)
    TriggerEvent('hud:voice:talking', false)
    TriggerScreenblurFadeOut(0)
end)

RegisterNUICallback("activeChar", function(data, cb)
    selecting = data.status
    SetEntityAlpha(CreatedPeds[data.id], 255, false)
end)

RegisterNUICallback("inactiveChar", function(data, cb)
    selecting = data.status
    for i = 1, 5 do
        SetEntityAlpha(CreatedPeds[i], 102, false)
    end
end)

RegisterNUICallback("hoveredChar", function(data, cb)
    if not selecting then
        SetEntityAlpha(CreatedPeds[data.id], 255, false)
    end
end)

RegisterNUICallback("unhoverChar", function(data, cb)
    SetEntityAlpha(CreatedPeds[data.id], 102, false)
end)

RegisterNUICallback("deleteCharacter", function(data, cb)
    selecting = false
    SendNUIMessage({
        action = "close"
    })
    for k, v in pairs(CreatedPeds) do 
        DeletePed(v)
    end
    TriggerServerEvent("urp-login:DeleteCharacter", data.cid)
end)

RegisterNUICallback("newCharacter", function(data, cb)
    TriggerServerEvent('es:firstJoinProper')
	TriggerEvent('es:allowedToSpawn')
    selecting = false
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(false, false)
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
    RenderScriptCams(false, true, 900, true, true)
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true, 0)
    for k, v in pairs(CreatedPeds) do
        DeletePed(v)
    end
    TriggerEvent('urp-identity:showRegisterIdentity')
    TriggerEvent("hud:voice:transmitting", false)
    TriggerEvent('hud:voice:talking', false)
    SendNUIMessage({
    action = "displayback"
    })
    SetTimecycleModifier('default')
    FreezeEntityPosition(GetPlayerPed(-1), true)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamRot(cam, 0.0, 0.0, -45.0, 2)
    SetCamCoord(cam, -682.0, -1092.0, 226.0)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    TriggerEvent("hud:voice:transmitting", false)
    TriggerEvent('hud:voice:talking', false)
    TriggerScreenblurFadeOut(0)
end)

RegisterNetEvent('urp-login:DeleteComplete')
AddEventHandler('urp-login:DeleteComplete', function()
    TriggerServerEvent("clothing:getCharactersAndClothes")
end)

RegisterNetEvent('urp-login:newCharacterComplete')
AddEventHandler('urp-login:newCharacterComplete', function(newCID)
end)

RegisterNetEvent('urp-login:doWalk')
AddEventHandler('urp-login:doWalk', function(ped)
    TaskGoToCoordAnyMeans(ped, WalkToSpot.x, WalkToSpot.y, WalkToSpot.z, 1.8, 0, 0, 786603, 0xbf800000)
    Wait(2000)
    local lib = "anim@arena@celeb@podium@no_prop@"
    local anim = "regal_c_1st"
    loadAnimDict(lib)
    TaskPlayAnim(ped, lib, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
end)


function SetHeadStructure(ped, data)
    for i = 1, #face_features do
        SetPedFaceFeature(ped, i-1, data[i])
    end
end

function SetHeadOverlayData(ped, data)
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            SetPedHeadOverlay(ped,  i-1, tonumber(data[i].overlayValue),  tonumber(data[i].overlayOpacity))
        end
        SetPedHeadOverlayColor(ped, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(ped, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(ped, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(ped, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(ped, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(ped, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(ped, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(ped, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(ped, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(ped, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(ped, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(ped, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

function SetClothing(ped, drawables, props, drawTextures, propTextures)
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(ped, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(ped, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(ped, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(ped, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(ped, i-1)
        SetPedPropIndex(ped, i-1, propZ, propTextures[i][2], true)
    end
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
end


function SetupSpawn()
    local ped = PlayerPedId()
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    DoScreenFadeOut(0)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    local model = `mp_m_freemode_01`
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    local spawn = vector3(-218.53842163086,-1026.4545898438,29.142059326172)
    RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)
    SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
    NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, 247.83258056641, true, true, false)
    if GetIsLoadingScreenActive() then
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
    end
end

AddEventHandler('onClientMapStart', function()
    print("MAP IS NOW LOADED")
    mapLoaded = true
end)

function getCid(identifier) 
    local result = MySQL.Sync.fetchAll("SELECT characters.cid FROM characters WHERE characters.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].cid
    end
    return nil
end

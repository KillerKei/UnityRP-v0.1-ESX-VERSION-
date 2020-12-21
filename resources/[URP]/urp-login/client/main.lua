URPCore              = nil
local PlayerData = {}
Citizen.CreateThread(function()
	while URPCore == nil do
		TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('urp:playerLoaded')
AddEventHandler('urp:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('urp:setJob')
AddEventHandler('urp:setJob', function(job)
  PlayerData.job = job
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
            Citizen.Wait(500)
           --TriggerServerEvent("urp-login:SetupCharacters")
			TriggerServerEvent("urp-scoreboard:AddPlayer")
			TriggerServerEvent('urp-admin:AddPlayer')
			TriggerEvent("urp-login:WelcomePage")
			TriggerEvent("urp-login:SetupCharacters")
            return -- break the loop
        end
    end
end)

local IsChoosing = true
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
		if IsChoosing then
			TriggerScreenblurFadeIn(0)
		end

		if Logout then
			for i=1, #Config.Logouts, 1 do
				local player = GetPlayerPed(-1)
				local playerloc = GetEntityCoords(player, 0)
				local logoutspot = Config.Logouts[i]
				local logoutdistance = GetDistanceBetweenCoords(logoutspot['x'], logoutspot['y'], logoutspot['z'], playerloc['x'], playerloc['y'], playerloc['z'], true)
				if logoutdistance <= 8 then
					DrawText3Ds(logoutspot.x,logoutspot.y,logoutspot.z + 0.10, "/logout to swap characters")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	if Logout then
		for i=1, #Config.Logouts, 1 do
			local logoutspot = Config.Logouts[i]
			local blip = AddBlipForCoord(logoutspot)

			SetBlipSprite(blip, 480)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.75)
			SetBlipColour(blip, 4)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Logout")
			EndTextCommandSetBlipName(blip)
		end
	end
end)

local cam = nil
local cam2 = nil
RegisterNetEvent('urp-login:SetupCharacters')
AddEventHandler('urp-login:SetupCharacters', function()
    SetTimecycleModifier('hud_def_blur')
    --FreezeEntityPosition(GetPlayerPed(-1), true)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 256.32,-1055.71,369.89, 300.00,0.00,0.00, 100.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end)

RegisterNetEvent('urp-login:WelcomePage')
AddEventHandler('urp-login:WelcomePage', function()
    SetNuiFocus(true, true)
	SendNUIMessage({
        action = "openwelcome"
    })
end)

RegisterNetEvent('urp-login:SetupUI')
AddEventHandler('urp-login:SetupUI', function(Characters)
	IsChoosing = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openui",
        characters = Characters,
    })
end)

RegisterCommand('logout', function(source, args, rawCommand)
	for i=1, #Config.Logouts, 1 do
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)
		local logoutspot = Config.Logouts[i]
		local logoutdistance = GetDistanceBetweenCoords(logoutspot['x'], logoutspot['y'], logoutspot['z'], playerloc['x'], playerloc['y'], playerloc['z'], true)

		--TriggerEvent("urp-login:SaveSwitchedPlayer")
		if logoutdistance <= 3 then
			TriggerEvent('ls-radio:onRadioDrop')
			TriggerEvent('urp-login:ReloadCharacters')
		end
	end
end)

RegisterNetEvent('urp-login:SpawnCharacter')
AddEventHandler('urp-login:SpawnCharacter', function(spawn, isnew)
	TriggerServerEvent('es:firstJoinProper')
    TriggerEvent('es:allowedToSpawn')
    local pos = spawn
    Citizen.Wait(0)
    if isnew then
        IsChoosing = false
        SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
        TriggerEvent('irp-identity:showRegisterIdentity')
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
    else
        SetTimecycleModifier('default')
        local pos = spawn
        exports.spawnmanager:setAutoSpawn(false)
        IsChoosing = false
        Citizen.Wait(5)
        TriggerEvent("hotel:createRoom")
        TriggerEvent("DoLongHudText", "Tax is currently set to: 15%", 1)
        TriggerServerEvent("irp-clothing:get_character_current")
        TriggerServerEvent("irp-clothing:get_character_face")
        TriggerServerEvent("irp-clothing:retrieve_tats")
        TriggerEvent("hud:voice:transmitting", false)
        TriggerEvent('hud:voice:talking', false)
        TriggerScreenblurFadeOut(0)
    end
end)

RegisterNetEvent('urp-login:ReloadCharacters')
AddEventHandler('urp-login:ReloadCharacters', function()
    TriggerServerEvent("urp-login:SetupCharacters")
    TriggerEvent("urp-login:SetupCharacters")
end)

RegisterNUICallback("CharacterChosen", function(data, cb)
    SetNuiFocus(false,false)
    TriggerServerEvent('urp-login:CharacterChosen', data.charid, data.ischar, data.spawnid or "1")
    cb("ok")
end)
RegisterNUICallback("DeleteCharacter", function(data, cb)
    SetNuiFocus(false,false)
    TriggerServerEvent('urp-login:DeleteCharacter', data.charid)
    cb("ok")
end)
RegisterNUICallback("ShowSelection", function(data, cb)
	TriggerServerEvent("urp-login:SetupCharacters")
end)

function DrawText3Ds(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	if onScreen then
		SetTextScale(0.30, 0.30)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0120, factor, 0.026, 41, 11, 41, 68)
	end
end
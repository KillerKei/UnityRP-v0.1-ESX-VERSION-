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
    else
        SetTimecycleModifier('default')
        local pos = spawn
        exports.spawnmanager:setAutoSpawn(false)
        IsChoosing = false
        TriggerEvent("hotel:createRoom")
        Citizen.Wait(10)
        TriggerServerEvent('urp-identity:UpdateJob')
        TriggerServerEvent('urp-identity:UpdateCid')
        local cid = exports["isPed"]:isPed("cid")
		TriggerServerEvent('hotel:load')
        TriggerServerEvent('refresh', cid)
        TriggerEvent("DoLongHudText", "Tax is currently set to: 15%", 1)
        TriggerServerEvent("server-request-update", source);
        TriggerServerEvent("server-update-item", source)
		TriggerEvent('urp-clothing:get_character_current', source)
		TriggerEvent("urp-clothing:get_character_face", source)
		TriggerEvent("urp-clothing:get_character_current", source)
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

--URP-BLIPS 
local blips = {
	 {name="Clothing Shop", color=3, id=73, x=72.254, y=-1399.102, z=28.376},
	 {name="Clothing Shop", color=3, id=73, x=-703.776,  y=-152.258,  z=36.415},
	 {name="Clothing Shop", color=3, id=73, x=-167.863,  y=-298.969,  z=38.733},
	 {name="Clothing Shop", color=3, id=73, x=428.694,   y=-800.106,  z=28.491},
	 {name="Clothing Shop", color=3, id=73, x=-829.413,  y=-1073.710, z=10.328},
	 {name="Clothing Shop", color=3, id=73, x=-1447.797, y=-242.461,  z=48.820},
	 {name="Clothing Shop", color=3, id=73, x=11.632,    y=6514.224,  z=30.877},
	 {name="Clothing Shop", color=3, id=73, x=123.646,   y=-219.440,  z=53.557},
	 {name="Clothing Shop", color=3, id=73, x=1696.291,  y=4829.312,  z=41.063},
	 {name="Clothing Shop", color=3, id=73, x=618.093,   y=2759.629,  z=41.088},
	 {name="Clothing Shop", color=3, id=73, x=1190.550,  y=2713.441,  z=37.222},
	 {name="Clothing Shop", color=3, id=73, x=-1193.429, y=-772.262,  z=16.324},
	 {name="Clothing Shop", color=3, id=73, x=-3172.496, y=1048.133,  z=19.863},
	 {name="Clothing Shop", color=3, id=73, x=-1108.441, y=2708.923,  z=18.107},
     {name="Clothing Shop", color=3, id=73, x=1858.9041748047, y=3687.8701171875,  z=34.267036437988},
     {name="Recycling plant", color=17, id=304, x = 746.75518798828, y=-1400.094482421, z=26.570837020874},
     {name="Los Santos Courthouse", color=5, id=58, x=244.5550079345, y=-386.0076904298, z=45.402359008789315},
     {name="The Winery", color=6, id=478,x = -1889.86, y = 2036.54, z = 140.83},
	 {name="Clothing Shop", color=3, id=73, x=2435.4169921875, y=4965.6123046875,  z=46.810600280762}
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.color)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.name)
      EndTextCommandSetBlipName(info.blip)
    end
end)
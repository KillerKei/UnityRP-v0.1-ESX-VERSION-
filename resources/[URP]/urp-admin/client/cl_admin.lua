function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

local checkingForSessions
local exludedZones = {
    [1] = {['x'] = 238.41,['y'] = -404.68,['z'] = 47.93,["r"] = 20},
    [2] = {['x'] = 234.16,['y'] = -418.85,['z'] = -118.19,["r"] = 60},
    [3] = {['x'] = 257.02,['y'] = -368.93,['z'] = -44.13,["r"] = 40},
    [4] = {['x'] = 323.47,['y'] = -1619.64,['z'] = -66.78,["r"] = 100},
}

local isInNoclip = false
local devmodeToggle = false

function URP.Admin.CheckForSessions(self)
    if checkingForSessions then return else checkingForSessions = true end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2000)

            local players = URP._Admin.Players

            for k,v in pairs(players) do
                local src = v.src
                local playerId = GetPlayerFromServerId(src)
                if not src then
                    URP._Admin.Players[src].sessioned = true
                else
                    if not NetworkIsPlayerActive(playerId) or not NetworkIsPlayerConnected(playerId) then URP._Admin.Players[src].sessioned = true end
                end
            end
        end
    end)
end

function URP.Admin.Init(self)
    self.Menu:Init()
    self:CheckForSessions()
    self:AFKCheck()
   -- SetRichPresence("Eating Chicken")
end

local afk = {
    checkingAFK = nil,
    isAfk = false,
    msgAFK = false,
    stringToType = "",
    event = nil,
    posStart = nil,
    afkStart = nil
}
stop = true
function URP.Admin.BeginAFK(self, stop)
    if stop then
        afk.isAfk = false
        afk.msgAFK = false
        afk.stringToType = ""
        afk.afkStart = nil
        afk.posStart = nil
        URP.Admin:SetStatus("Playing")
        if afk.event then
            RemoveEventHandler(afk.event)
        end
        return
    end

    if afk.msgAFK then return end

    self:SetStatus("AFK")
    afk.stringToType = ""

    for i = 1, 5 do
        local c = string.char(GetRandomIntInRange(97, 122))
        afk.stringToType = afk.stringToType .. string.lower(c)
    end

    afk.event = AddEventHandler("urp-admin:afkStringCheck", function(text)
        if string.lower(text) == afk.stringToType then URP.Admin:BeginAFK(true) return end
    end)

    afk.msgAFK = true
    local beginTime = GetGameTimer()

    Citizen.CreateThread(function()
        local lastNotify = 0

        while true do
            Citizen.Wait(1000)

            if not afk.msgAFK then return end
            
            local curTime = GetGameTimer()

            if curTime - lastNotify >= 6500 then
                lastNotify = GetGameTimer()

                local string = [[<center><span style="font-size:28px;color:red;">You have been detected as AFK. Please type the message below within 5 minutes!<br /><hr style="border-color: rgba(255, 0, 0, 0.5);">%s</span></center>]]
                TriggerEvent("pNotify:SendNotification", {text = string.format(string, afk.stringToType), layout = "top", timeout = 5000, type = "error", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}, queue = "afk", progressBar = false})
            end

            if curTime - beginTime >= 300000 then TriggerServerEvent("urp-admin:Disconnect", "AFK Kick") return end
        end
    end)
end

function URP.Admin.AFKCheck(self)
    if afk.checkingAFK then return else afk.checkingAFK = true end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            
            local curPos = GetEntityCoords(ped, false)
            local curTime = GetGameTimer()

            local rank = URP.Admin:GetPlayerRank()
            local rankData = URP.Admin:GetRankData(rank)
            local inExluded = false

            for i,v in ipairs(exludedZones) do
                if #(vector3(v.x,v.y,v.z) - GetEntityCoords(PlayerPedId())) < v.r then
                    inExluded = true
                end
            end

            if rankData and not rankData.allowafk and not inExluded then
                afk.posStart = afk.posStart and afk.posStart or curPos

                if Vdist2(afk.posStart, curPos) <= 20.0 then afk.afkStart = afk.afkStart and afk.afkStart or GetGameTimer() else afk.afkStart = nil afk.posStart = nil end
                if IsPedRagdoll(ped) then afk.afkStart = nil afk.posStart = nil end

                if afk.afkStart and curTime - afk.afkStart >= 1200000 and not afk.isAfk then
                    URP.Admin:BeginAFK()
                else
                    if afk.isAfk == true then
                        URP.Admin:BeginAFK(true)
                    end
                end
            end
        end
    end)
end

RegisterNetEvent("urp-admin:afkStringCheck")

RegisterNetEvent("urp-admin:setStatus")
AddEventHandler("urp-admin:setStatus", function(src, status)
    local player = URP._Admin.Players[src]
    if not player then return else URP._Admin.Players[src].status = status end
end)

RegisterNetEvent("urp-admin:sendPlayerInfo")
AddEventHandler("urp-admin:sendPlayerInfo", function(data, discData)
    URP._Admin.Players = data
    URP._Admin.DiscPlayers = discData
end)

RegisterNetEvent("urp-admin:RemovePlayer")
AddEventHandler("urp-admin:RemovePlayer", function(data)
    URP._Admin.DiscPlayers[data.src] = data
    URP._Admin.Players[data.src] = nil
end)

RegisterNetEvent("urp-admin:AddPlayer")
AddEventHandler("urp-admin:AddPlayer", function(player)
    URP._Admin.Players[player.src] = player
end)

RegisterNetEvent("urp-admin:AddAllPlayers")
AddEventHandler("urp-admin:AddAllPlayers", function(data)
    URP._Admin.Players[data.src] = data
end)


RegisterNetEvent('event:control:adminDev')
AddEventHandler('event:control:adminDev', function(useID)
    if not devmodeToggle then return end
    if URP.Admin:GetPlayerRank() == "dev" then
        if useID == 1 then
            TriggerEvent("urp-admin:openMenu")
        elseif useID == 2 then
            local bool = not isInNoclip
            URP.Admin.RunNclp(nil,bool)
            TriggerEvent("urp-admin:NoclipState",bool)
            TriggerServerEvent("admin:noclipFromClient",bool)
        elseif useID == 3 then
            TriggerEvent("urp-admin:CloakRemote")
        elseif useID == 4 then
            URP.Admin.teleportMarker(nil)
        end
    end
end)

RegisterNetEvent("urp-admin:currentDevmode")
AddEventHandler("urp-admin:currentDevmode", function(devmode)
    devmodeToggle = devmode
end)

function URP.Admin.RunCommand(self, args)
    if not args or not args.command then return end
    TriggerServerEvent("urp-admin:runCommand", args)
end

function URP.Admin.RunClCommand(self, cmd, args)
    if not cmd or not self:CommandExists(cmd) then return end
    self:GetCommandData(cmd).runclcommand(args)
end


function URP.Admin.teleportMarker(self)
    local rank = URP.Admin:GetPlayerRank()
    local rankData = URP.Admin:GetRankData(rank)

    if rankData and rankData.grant < 90 then return end

    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                break
            end

            Citizen.Wait(5)
        end

    else
        TriggerEvent("Notification", 'Failed to find marker.',2)
    end

end

function URP.Admin.split(source, sep)
    local result, i = {}, 1
    while true do
        local a, b = source:find(sep)
        if not a then break end
        local candidat = source:sub(1, a - 1)
        if candidat ~= "" then 
            result[i] = candidat
        end i=i+1
        source = source:sub(b + 1)
    end
    if source ~= "" then 
        result[i] = source
    end
    return result
end

function URP.Admin.RunNclp(self,bool)
    local cmd = {}
    cmd = {
        vars = {}
    }


    local rank = URP.Admin:GetPlayerRank()
    local rankData = URP.Admin:GetRankData(rank)

    if rankData and rankData.grant < 90 then return end
    
    if bool and isInNoclip then return end
    isInNoclip = bool
    if not isInNoclip then return end

    Citizen.CreateThread(function()
        local speed = 0.5
        while isInNoclip do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            cmd.vars.targetEntity = playerPed
            cmd.vars.heading = cmd.vars.heading == nil and GetEntityHeading(playerPed) or cmd.vars.heading
            cmd.vars.noclip_pos = cmd.vars.noclip_pos == nil and GetEntityCoords(playerPed, false) or cmd.vars.noclip_pos

            SetPlayerInvincible(PlayerId(), true)

            if IsPedInAnyVehicle(playerPed, true) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                if vehicle and vehicle ~= 0 then
                    if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                        cmd.vars.targetEntity = vehicle
                    end
                end
            end

            SetEntityCollision(cmd.vars.targetEntity,false, false)

            SetEntityCoordsNoOffset(cmd.vars.targetEntity,  cmd.vars.noclip_pos.x,  cmd.vars.noclip_pos.y,  cmd.vars.noclip_pos.z,  0, 0, 0)

            if IsControlPressed(1, 34) then
                cmd.vars.heading = cmd.vars.heading + 1.5
                if cmd.vars.heading > 360 then
                    cmd.vars.heading = 0
                end
                SetEntityHeading(cmd.vars.targetEntity,  cmd.vars.heading)
            end

            if IsControlPressed(1, 9) then
                cmd.vars.heading = cmd.vars.heading - 1.5
                if cmd.vars.heading < 0 then
                    cmd.vars.heading = 360
                end
                SetEntityHeading(cmd.vars.targetEntity,  cmd.vars.heading)
            end

            if IsControlPressed(0, 8) then
                cmd.vars.noclip_pos = GetOffsetFromEntityInWorldCoords(cmd.vars.targetEntity, 0.0, -speed, 0.0)
            end

            if IsControlPressed(0, 32) then
                cmd.vars.noclip_pos = GetOffsetFromEntityInWorldCoords(cmd.vars.targetEntity, 0.0, speed, 0.0)
            end

            if IsControlPressed(0, 22) then
                cmd.vars.noclip_pos = GetOffsetFromEntityInWorldCoords(cmd.vars.targetEntity, 0.0, 0.0, speed)
            end
            if IsControlPressed(0, 73) then
                cmd.vars.noclip_pos = GetOffsetFromEntityInWorldCoords(cmd.vars.targetEntity, 0.0, 0.0, -speed)
            end

            if IsControlJustPressed(0, 131) then
                if speed >= 6.5 then speed = 0.5 else speed = speed + 1.0 end
            end
        end
        cmd.vars.heading = nil 
        cmd.vars.noclip_pos = nil 
        SetPlayerInvincible(PlayerId(), false) 
        SetEntityCollision(cmd.vars.targetEntity,true, true) 
        cmd.vars.targetEntity = nil
    end)
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

RegisterNetEvent("urp-admin:RunClCommand")
AddEventHandler("urp-admin:RunClCommand", function(cmd, args)
    URP.Admin:RunClCommand(cmd, args)
end)

RegisterNetEvent("urp-admin:updateData")
AddEventHandler("urp-admin:updateData", function(src, type, data)
    if not src or not type or not data then return end
    if not URP._Admin.Players[src] then return end
    
    URP._Admin.Players[src][type] = data
end)

RegisterNetEvent("urp-admin:noLongerAdmin")
AddEventHandler("urp-admin:noLongerAdmin", function()
    URP._Admin.Players = {}
    
    for k,v in pairs(URP._Admin.Menu.Menus) do
        if WarMenu.IsMenuOpened(k) then WarMenu.CloseMenu() end
    end
end)

RegisterNetEvent("urp-admin:bringPlayer")
AddEventHandler("urp-admin:bringPlayer", function(targPos)
    local ped = PlayerPedId()


    Citizen.CreateThread(function()
        RequestCollisionAtCoord(targPos[1],targPos[2],targPos[3])
        SetEntityCoordsNoOffset(PlayerPedId(), targPos[1],targPos[2],targPos[3], 0, 0, 2.0)
        FreezeEntityPosition(PlayerPedId(), true)
        SetPlayerInvincible(PlayerId(), true)

        local startedCollision = GetGameTimer()

        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
            if GetGameTimer() - startedCollision > 5000 then break end
            Citizen.Wait(0)
        end

        FreezeEntityPosition(PlayerPedId(), false)
        SetPlayerInvincible(PlayerId(), false)
    end)    
end)

RegisterNetEvent("urp-admin:bring")
AddEventHandler("urp-admin:bring", function(target)
    local posR = GetEntityCoords(PlayerPedId(), false)

    local pos = {}
    pos[1] = posR.x
    pos[2] = posR.y
    pos[3] = posR.z

    TriggerServerEvent("urp-admin:bringPlayerServer",pos,target)   
end)



local LastVehicle = nil
RegisterNetEvent("urp-admin:runSpawnCommand")
AddEventHandler("urp-admin:runSpawnCommand", function(model, livery)
    Citizen.CreateThread(function()

        local hash = GetHashKey(model)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

        local localped = PlayerPedId()
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 5.0, 0.0)

        local heading = GetEntityHeading(localped)
        local vehicle = CreateVehicle(hash, coords, heading, true, false)

        SetVehicleModKit(vehicle, 0)
        SetVehicleMod(vehicle, 11, 3, false)
        SetVehicleMod(vehicle, 12, 2, false)
        SetVehicleMod(vehicle, 13, 2, false)
        SetVehicleMod(vehicle, 15, 3, false)
        SetVehicleMod(vehicle, 16, 4, false)
        DecorSetInt(vehicle,"GamemodeCar",955)


        if model == "pol1" then
            SetVehicleExtra(vehicle, 5, 0)
        end

        if model == "police" then
            SetVehicleWheelType(vehicle, 2)
            SetVehicleMod(vehicle, 23, 10, false)
            SetVehicleColours(vehicle, 0, false)
            SetVehicleExtraColours(vehicle, 0, false)
        end

        if model == "pol7" then
            SetVehicleColours(vehicle,0)
            SetVehicleExtraColours(vehicle,0)
        end

        if model == "pol5" or model == "pol6" then
            SetVehicleExtra(vehicle, 1, -1)
        end


        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerServerEvent("garage:addKeys",plate)
       -- TriggerServerEvent('garages:addJobPlate', plate)
        SetModelAsNoLongerNeeded(hash)
        
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)

        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end)


RegisterNetEvent("urp-admin:SeatIntoLast")
AddEventHandler("urp-admin:SeatIntoLast", function()
    local rank = URP.Admin:GetPlayerRank()
    local rankData = URP.Admin:GetRankData(rank)

    if rankData and rankData.grant < 90 then return end
    if LastVehicle ~= nil then
        TaskWarpPedIntoVehicle(PlayerPedId(),LastVehicle,-1)
    else
         TriggerEvent("Notification", 'Failed to find Vehicle.',2)
    end
end)

RegisterNetEvent("urp-admin:ReviveInDistance")
AddEventHandler("urp-admin:ReviveInDistance", function()
    local playerList = {}

    local players = GetPlayers()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)


    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
        local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
        if(distance < 50) then
            playerList[index] = GetPlayerServerId(value)
    end

    if playerList ~= {} and playerList ~= nil then
        TriggerServerEvent("admin:reviveAreaFromClient",playerList)

        for k,v in pairs(playerList) do
            TriggerServerEvent('urp-ambulancejob:revive', v)
            TriggerServerEvent('urp-ambulancejob:revive', source)
            --  TriggerServerEvent("reviveGranted", v)
            --  TriggerEvent("Hospital:HealInjuries",true) 
            --  TriggerServerEvent("ems:healplayer", v)
            --  TriggerEvent("heal")
        end
    end
end
    
end)


URP.Admin:Init()

RegisterNetEvent('cloak')
AddEventHandler('cloak', function(state)
    SetEntityVisible(PlayerPedId(), state, 2)
end)

RegisterNetEvent('urp-admin:setmodel')
AddEventHandler('urp-admin:setmodel', function(model)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        SetPedRandomComponentVariation(GetPlayerPed(-1), true)
    end
end)

--  RegisterCommand('addplayerplswork', function()
--      TriggerServerEvent("urp-admin:AddPlayer")
--  end)

RegisterNetEvent('urp-admin:repair')
AddEventHandler('urp-admin:repair', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then 
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
    end 
end)
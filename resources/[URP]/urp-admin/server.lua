URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

URP = URP or {}
URP.Admin = URP.Admin or {}
URP._Admin = URP._Admin or {}
URP._Admin.Players = {}
URP._Admin.DiscPlayers = {}
local job = nil

RegisterServerEvent('admin:setGroup')
AddEventHandler('admin:setGroup', function(target, rank)
    local source = source
    TriggerEvent("es:setPlayerData", target.src, "group", rank, function(response, success)
        TriggerClientEvent('es_admin:setGroup', target.src, rank)
        TriggerClientEvent('DoLongHudText', source, "Set " .. target.src .. "'s rank to " .. rank .. "!")
    end)
end)

RegisterServerEvent('urp-admin:Cloak')
AddEventHandler('urp-admin:Cloak', function(src, toggle)
    TriggerClientEvent("urp-admin:Cloak", -1, src, toggle)
end)

RegisterServerEvent('admin:addChatMessage')
AddEventHandler('admin:addChatMessage', function(message)
    TriggerClientEvent('chatMessagess', -1, 'Admin: ', 3, message)
end)

RegisterServerEvent('admin:addChatAnnounce')
AddEventHandler('admin:addChatAnnounce', function(message)
    TriggerClientEvent('chatMessagess', -1, 'Announcement: ', 4, message)
end)

RegisterServerEvent('urp-admin:RaveMode')
AddEventHandler('urp-admin:RaveMode', function(toggle)
    local source = source
    TriggerClientEvent('urp-admin:toggleRave', -1, toggle)
end)

RegisterServerEvent('urp-admin:AddPlayer')
AddEventHandler("urp-admin:AddPlayer", function()
    local _source = source
    local xPlayer = URPCore.GetPlayerFromId(_source)
    --local identifier = xPlayer.identifier
    local licenses
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            licenses = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local licenseid = licenses:gsub("license:", "")
    local ping = GetPlayerPing(source)
    local data = { src = source, steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping}

    TriggerClientEvent("urp-admin:AddPlayer", -1, data )
    --URP.Admin.AddAllPlayers()
end)

RegisterServerEvent('admin:bringPlayer')
AddEventHandler('admin:bringPlayer', function(target)
    local source = source
    local coords = GetEntityCoords(GetPlayerPed(source))
    TriggerClientEvent('es_admin:teleportUser', target, coords.x, coords.y, coords.z)
    TriggerClientEvent('DoLongHudText', source, 'You brought this player.')
end)

function URP.Admin.AddAllPlayers(self)
    local xPlayers   = URPCore.GetPlayers()

    for i=1, #xPlayers, 1 do
        
        local licenses
        local identifiers, steamIdentifier = GetPlayerIdentifiers(xPlayers[i])
        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end
        for _, v in pairs(identifiers) do
            if string.find(v, "license") then
                licenses = v
                break
            end
        end
        local ip = GetPlayerEndpoint(xPlayers[i])
        local licenseid = licenses:gsub("license:", "")
        local ping = GetPlayerPing(xPlayers[i])
        local stid = HexIdToSteamId(steamIdentifier)
        local ply = GetPlayerName(xPlayers[i])
        local scomid = steamIdentifier:gsub("steam:", "")
        local data = { src = xPlayers[i], steamid = stid, comid = scomid, name = ply, ip = ip, hexid = steamIdentifier, license = licenseid, ping = ping }

        TriggerClientEvent("urp-admin:AddAllPlayers", source, data)

    end
end

function URP.Admin.AddPlayerS(self, data)
    URP._Admin.Players[data.src] = data
end

AddEventHandler("playerDropped", function()
	local licenses
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            licenses = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local licenseid = licenses:gsub("license:", "")
    local ping = GetPlayerPing(source)
    local data = { src = source, steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping}

    TriggerClientEvent("urp-admin:RemovePlayer", -1, data )
    Wait(600000)
    TriggerClientEvent("urp-admin:RemoveRecent", -1, data)
end)



function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end







RegisterServerEvent('urp-admin:setjob')
AddEventHandler('urp-admin:setjob', function(args)
    local _source = source
    local xPlayer = URPCore.GetPlayerFromId(_source)
    job = args
    if job == 1 then
        xPlayer.setJob("police", 0)
        TriggerClientEvent('DoLongHudText', _source, 'New Job: Law Enforcement')
    elseif job == 2 then
        xPlayer.setJob("ems", 0)
        TriggerClientEvent('DoLongHudText', _source, 'New Job: Medical Department')
    elseif job == 3 then
        xPlayer.setJob("gov", 0)
        TriggerClientEvent('DoLongHudText', _source, 'New Job: Government')
    elseif job == 4 then
        xPlayer.setJob('realestate', 0)
        TriggerClientEvent('DoLongHudText', _source, 'New Job: RealEstate')
    end
end)

RegisterServerEvent('urp-admin:setcloak')
AddEventHandler('urp-admin:setcloak', function(args)
    TriggerClientEvent('cloak', source, args)
end)

RegisterServerEvent('urp-admin:kick')
AddEventHandler('urp-admin:kick', function(kickid, reason)
    DropPlayer(kickid, reason)
end)

RegisterServerEvent('urp-admin:repair')
AddEventHandler('urp-admin:repair', function(target)
TriggerClientEvent('urp-admin:repair', target)
end)
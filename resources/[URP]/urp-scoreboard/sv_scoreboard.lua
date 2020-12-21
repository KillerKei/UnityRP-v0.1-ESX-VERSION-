local URPCore

local URP = URP or {}
URP.Scoreboard = {}
URP._Scoreboard = {}
URP._Scoreboard.PlayersS = {}
URP._Scoreboard.RecentS = {}

TriggerEvent("urp:getSharedObject", function(obj) URPCore = obj end)

RegisterServerEvent('urp-scoreboard:AddPlayer')
AddEventHandler("urp-scoreboard:AddPlayer", function()

    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local data = { src = source, steamid = stid, comid = scomid, name = ply }

    TriggerClientEvent("urp-scoreboard:AddPlayer", -1, data )
    URP.Scoreboard.AddAllPlayers()
end)

function URP.Scoreboard.AddAllPlayers(self)
    local xPlayers   = URPCore.GetPlayers()

    for i=1, #xPlayers, 1 do
        
        local identifiers, steamIdentifier = GetPlayerIdentifiers(xPlayers[i])
        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end

        local stid = HexIdToSteamId(steamIdentifier)
        local ply = GetPlayerName(xPlayers[i])
        local scomid = steamIdentifier:gsub("steam:", "")
        local data = { src = xPlayers[i], steamid = stid, comid = scomid, name = ply }

        TriggerClientEvent("urp-scoreboard:AddAllPlayers", source, data)

    end
end

function URP.Scoreboard.AddPlayerS(self, data)
    URP._Scoreboard.PlayersS[data.src] = data
end

AddEventHandler("playerDropped", function()
	local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local plyid = source
    local data = { src = source, steamid = stid, comid = scomid, name = ply }

    TriggerClientEvent("urp-scoreboard:RemovePlayer", -1, data )
    Wait(600000)
    TriggerClientEvent("urp-scoreboard:RemoveRecent", -1, plyid)
end)

--[[ function URP.Scoreboard.RemovePlayerS(self, data)
    URP._Scoreboard.RecentS = data
end

function URP.Scoreboard.RemoveRecentS(self, src)
    URP._Scoreboard.RecentS.src = nil
end ]]

function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end
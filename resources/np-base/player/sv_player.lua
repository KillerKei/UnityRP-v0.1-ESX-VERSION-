NPX.Player = NPX.Player or {}
NPX.LocalPlayer = NPX.LocalPlayer or {}

function GetUser()
    return NPX.Players
end

function NPX.Player.setVar(self, var, data)
    GetUser()[var] = data
end

function NPX.Player.getVar(self, var)
    return GetUser()[var]
end

function NPX.Player.setCurrentCharacter(self, data, source)
    local _src = source
    if not data then return end
    GetUser():setVar("character", data)
    GetUser():setVar("source", _src)
end

RegisterNetEvent('np-base:setServerCharacter')
AddEventHandler('np-base:setServerCharacter', function(data)
    local character = data
    local _src = source
    local chara = NPX.Player:getVar('character')
    NPX.Player:setCurrentCharacter(character, _src)
end)
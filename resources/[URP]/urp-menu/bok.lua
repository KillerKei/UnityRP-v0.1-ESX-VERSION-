RegisterNetEvent('urp:examine')    
AddEventHandler('urp:examine', function()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local body = math.ceil(GetVehicleBodyHealth(vehicle)/100)
    local engine = math.ceil(GetVehicleEngineHealth(vehicle))
    local enginederece = math.ceil(GetVehicleEngineTemperature(vehicle))
    local petrol = math.ceil(GetVehiclePetrolTankHealth(vehicle)/400)
    local wheel = math.ceil(GetVehicleWheelHealth(vehicle, 1)/100) -- integer = Hangi tekerlek olacağı   https://runtime.fivem.net/doc/natives/?_0x6E13FC662B882D1D
    local enginetemplol = math.ceil(GetVehicleEngineTemperature(vehicle)/13)
        
    local bodyt = "Body: "..body.."/10"
    local enginet = "Engine: "..engine.."/10"
    local enginetempt = "Engine Temp: "..enginederece.."."..enginetemplol.."/200"
    local fueltankt = "Fuel Tank: "..petrol.."/10"
    local wheelt = "Wheels: "..wheel.."/10"
    if IsPedInAnyVehicle(ped, true) then
        TriggerServerEvent("youshitlord",bodyt,enginet,enginetempt,fueltankt,wheelt)
   else 
        TriggerEvent('DoLongHudText', 'You have to be in a vehicle to examine it!', 2)
    end
end)

RegisterCommand("examine", function()
    TriggerEvent('urp:examine')
end)
    
RegisterNetEvent('lol:shit')
    AddEventHandler('lol:shit', function()
    ExecuteCommand("givekey")
end)
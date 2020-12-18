URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)
local DontShowPoundCarsInGarage = true

RegisterServerEvent("garages:CheckGarageForVeh")
AddEventHandler("garages:CheckGarageForVeh", function()
    local src = source
    local xPlayer = URPCore.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    
	exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE `owner` = @identifier', { 
		['@identifier'] = identifier 
	}, function(vehicles)
		TriggerClientEvent('phone:Garage', src, vehicles)
    end)
end)

URPCore.RegisterServerCallback('garage:getOwnedCars', function(source, cb)
	local ownedCars = {}
	if DontShowPoundCarsInGarage then
		exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE `owner` = @owner LIMIT 25', {
			['@owner']  = GetPlayerIdentifiers(source)[1],
			['@Type']   = 'car',
			['@state'] = 'In'
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local body = v.body_damage
				local engine = v.engine_damage
				table.insert(ownedCars, {vehicle = vehicle, id = v.id, state = v.state, garage = v.garage, plate = v.plate, body_damage = v.body_damage, engine_damage = v.engine_damage})
			end
			cb(ownedCars)
		end)
	else
		exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE `owner` = @owner', {
			['@owner']  = GetPlayerIdentifiers(source)[1],
			['@state'] = 'Out',
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local body = v.body_damage
				local engine = v.engine_damage
				table.insert(ownedCars, {vehicle = vehicle, id = v.id, state = v.state, garage = v.garage, plate = v.plate})
			end
			cb(ownedCars)
		end)
	end
end)

RegisterServerEvent("garages:SetVehIn")
AddEventHandler("garages:SetVehIn",function(garage, plate, vehicleProps, realFuel)
	local src = source
	local user = URPCore.GetPlayerFromId(source)
	local characterId = user.identifier
	exports.ghmattimysql:execute("UPDATE owned_vehicles SET `vehicle` = @vehicle, `state` = @state, `garage` = @garage, `fuel` = @fuel, `engine_damage` = @engine_damage WHERE `plate` = @plate", {
		['vehicle'] = json.encode(vehicleProps), 
		['garage'] = garage, 
		['fuel'] = realFuel, 
		['state'] = "In", 
		['engine_damage'] = vehicleProps.engineHealth, 
		['body_damage'] = vehicleProps.bodyHealth, 
		['plate'] = plate
	})
	print(vehicleProps.modLivery)

end)

RegisterServerEvent('garages:CheckForSpawnVeh')
AddEventHandler('garages:CheckForSpawnVeh', function(veh_id, garageCost)
	local src = source
	local user = URPCore.GetPlayerFromId(source)
	local user = exports["urp-core"]:getCurrentCharacter(src)
    local uCash = user.money
	if uCash >= garageCost then
	if garageCost >= 1 then
		TriggerEvent('urp-core:removeCash', src, garageCost)
	else
		TriggerEvent('urp-core:removeCash', src, 0)
	end
		local veh_id = veh_id
		local player = user.identifier
		exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE `id` = @id', {
			['@id'] = veh_id
		}, function(result)
			local plate = result[1].plate
			local state = result[1].state
			local FuelSet = result[1].fuel
			vehiclse = json.decode(result[1].vehicle)
			vehicle = vehiclse
			TriggerClientEvent('garages:SpawnVehicle', src, vehicle, plate, state, FuelSet)
		end)
	else
		TriggerClientEvent('DoLongHudText', src, 'You need $' .. garageCost, 2)
	end
end)

RegisterServerEvent('garages:SetVehOut')
AddEventHandler('garages:SetVehOut', function(vehicle, plate)
	local src = source
	local user = URPCore.GetPlayerFromId(source)
	local player = user.identifier
	local vehicle = vehicle
	local plate = plate
	exports.ghmattimysql:execute("UPDATE owned_vehicles SET `state` = @state WHERE `plate` = @plate", {
		['garage'] = garage, 
		['state'] = "Out", 
		['plate'] = plate
	})
end)

RegisterServerEvent("garages:CheckForVeh")
AddEventHandler('garages:CheckForVeh', function()
	local src = source
	local user = URPCore.GetPlayerFromId(source)
	local player = user.identifier
	exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE `owner` = @owner AND `state` = @state', {
		['@owner'] = player, 
		['@state'] = "Out", 
		['@vehicle'] = vehicle
	}, function(result)
		if result[1] ~= nil then
			local plates = result[1].plate
			vehiclse = json.decode(result[1].vehicle)
			vehicle = vehiclse.model
			fuel = vehiclse.fuelLevel
			TriggerClientEvent('garages:StoreVehicle', src, plate)
		else
			TriggerClientEvent('DoLongHudText', src, 'You dont own this car!')
		end
		
	end)
end)

TriggerEvent('es:addCommand', 'impound', function(source, args, user)
	local usource = source
	local xPlayer = URPCore.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'mechanic' then
		TriggerClientEvent('tp:mechimpound', source)
	end
end)

RegisterServerEvent('imp:ImpoundCar')
AddEventHandler('imp:ImpoundCar', function(plate)
	exports.ghmattimysql:execute("UPDATE owned_vehicles SET `garage` = @garage, `state` = @state WHERE `plate` = @plate", {
		['garage'] = 'Impound Lot', 
		['state'] = 'Normal Impound', 
		['plate'] = plate
	})
end)

AddEventHandler('onResourceStart', function(resource)
	if GetCurrentResourceName() == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1)
			ResetVehicles()
		end)
	end
end)

function ResetVehicles()
	Citizen.CreateThread(function()
		exports.ghmattimysql:execute("UPDATE owned_vehicles SET `state` = @state", {
			['state'] = 'In',  
		})
	end)
end
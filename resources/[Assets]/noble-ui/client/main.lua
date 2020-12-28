ESX = nil

local PlayerData = {}
animatedUI = false
animatedEndUI = false
CloseUI = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

local thermite = {
    {x = 150.0983, y = -1040.51, z = 29.374}
}


function AnimateUI()
	if animatedUI == false then
	SendNUIMessage({
		action = "animation",
		display = true,
	})
	end
end 

function AnimateEndUI()
	if animatedEndUI == false then
	SendNUIMessage({
		action = "animationEnd",
		display = true,
	})
    end
end 

function FinishUI()
	AnimateEndUI()
	Citizen.Wait(1000)
	animatedEndUI = true
end

function StartUI(text)
	if CloseUI == false then
	SendNUIMessage({
		action = "notification",
		display = true,
		text = text,
	})
	end
end

function StopUI()
	SendNUIMessage({
		action = "notification",
		display = false,
	})
	CloseUI = true
end

function RestartUI()
	CloseUI = false
end

RegisterCommand('testui', function()
	StartUI('[E] Test')
	Citizen.Wait(1000)
	AnimateEndUI()
end)


-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(400)
-- 		for k,v in pairs(thermite) do
-- 			if Vdist2(GetEntityCoords(PlayerPedId(), false), v.x, v.y, v.z) < 2.0 then
-- 				SendNUIMessage({
-- 					action = "notification",
-- 					display = true,
-- 				})
-- 			else
-- 				SendNUIMessage({
-- 					action = "notification",
-- 					display = false,
-- 				})
-- 			end
-- 		end
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while thermite do
-- 		Citizen.Wait(400)
-- 		SendNUIMessage({
-- 			action = "notification",
-- 			display = true,
-- 		})
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		for k,v in pairs(thermite) do
			if Vdist2(GetEntityCoords(PlayerPedId(), false), v.x, v.y, v.z) < 2.0 then
				exports['noble-ui']:StartUI('[E] Bankayı Kullan')
				if IsControlJustPressed(0, 38) then
					exports['noble-ui']:StopUI()
					print('test')
				end
			else
				exports['noble-ui']:StopUI()
				exports['noble-ui']:RestartUI()
			end
		end
	end
end)
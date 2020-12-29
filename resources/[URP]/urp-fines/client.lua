URPCore = nil

Citizen.CreateThread(function()
	while URPCore == nil do
		TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)
		Citizen.Wait(0)
	end

	while URPCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = URPCore.GetPlayerData()
end)

RegisterNetEvent('urp-fines:Anim')
AddEventHandler('urp-fines:Anim', function()
	RequestAnimDict('mp_common')
    while not HasAnimDictLoaded('mp_common') do
        Citizen.Wait(5)
    end
    TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 8.0, -8, -1, 12, 1, 0, 0, 0)
end)
Citizen.CreateThread(function()
	local isDead = false

	while true do
		Citizen.Wait(100)

		local player = PlayerId()

		if NetworkIsPlayerActive(player) then
			local playerPed = PlayerPedId()

			if IsPedFatallyInjured(playerPed) and not isDead then
				isDead = true

				local killer, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
				local killerServerId = NetworkGetPlayerIndexFromPed(killer)
		
				if killer ~= playerPed and killerServerId ~= nil and NetworkIsPlayerActive(killerServerId) then
					PlayerKilledByPlayer(GetPlayerServerId(killerServerId), killerServerId, killerWeapon)
				else
					PlayerKilled()
				end

			elseif not IsPedFatallyInjured(playerPed) then
				isDead = false
			end
		end
	end
end)

function PlayerKilledByPlayer(killerServerId, killerClientId, killerWeapon)
	local victimCoords = GetEntityCoords(PlayerPedId())
	local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
	local distance     = GetDistanceBetweenCoords(victimCoords, killerCoords, true)

	local data = {
		victimCoords = { x = URPCore.Math.Round(victimCoords.x, 1), y = URPCore.Math.Round(victimCoords.y, 1), z = URPCore.Math.Round(victimCoords.z, 1) },
		killerCoords = { x = URPCore.Math.Round(killerCoords.x, 1), y = URPCore.Math.Round(killerCoords.y, 1), z = URPCore.Math.Round(killerCoords.z, 1) },

		killedByPlayer = true,
		deathCause     = killerWeapon,
		distance       = URPCore.Math.Round(distance, 1),

		killerServerId = killerServerId,
		killerClientId = killerClientId
	}

	TriggerEvent('urp:onPlayerDeath', data)
	TriggerServerEvent('urp:onPlayerDeath', data)
end

function PlayerKilled()
	local playerPed = PlayerPedId()
	local victimCoords = GetEntityCoords(PlayerPedId())

	local data = {
		victimCoords = { x = URPCore.Math.Round(victimCoords.x, 1), y = URPCore.Math.Round(victimCoords.y, 1), z = URPCore.Math.Round(victimCoords.z, 1) },

		killedByPlayer = false,
		deathCause     = GetPedCauseOfDeath(playerPed)
	}

	TriggerEvent('urp:onPlayerDeath', data)
	TriggerServerEvent('urp:onPlayerDeath', data)
end
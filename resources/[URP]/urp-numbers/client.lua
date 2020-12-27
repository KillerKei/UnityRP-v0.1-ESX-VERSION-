local JobCount = {}


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

RegisterNetEvent('urp:setJob')
AddEventHandler('urp:setJob', function(job)
	PlayerData.job = job
	TriggerServerEvent('urp-numbers:setjobs', job)
end)

RegisterNetEvent('urp:playerLoaded')
AddEventHandler('urp:playerLoaded', function(xPlayer)
    TriggerServerEvent('urp-numbers:setjobs', xPlayer.job)
end)


RegisterNetEvent('urp-numbers:setjobs')
AddEventHandler('urp-numbers:setjobs', function(jobslist)
   JobCount = jobslist
end)

function jobonline(joblist)
    for i,v in pairs(Config.MultiNameJobs) do
        for u,c in pairs(v) do
            if c == joblist then
                joblist = i
            end
        end
    end

    local amount = 0
    local job = joblist
    if JobCount[job] ~= nil then
        amount = JobCount[job]
    end

    return amount
end



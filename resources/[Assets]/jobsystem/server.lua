
URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)

RegisterServerEvent('jobsystem:Job')
AddEventHandler('jobsystem:Job', function(job)
	local xPlayer = URPCore.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.setJob(job, 0)
    end
end)

RegisterServerEvent('duty:on')
AddEventHandler('duty:on', function(bok)

    local _source = source
    local xPlayer = URPCore.GetPlayerFromId(_source)
    local job = xPlayer.job.name
	local grade = xPlayer.job.grade

	if bok == 'police' or bok == 'ambulance' then
		xPlayer.setJob(bok, grade)
	end
end)

RegisterServerEvent('duty:off')
AddEventHandler('duty:off', function(datajob)
	local _source = source
	local xPlayer = URPCore.GetPlayerFromId(_source)
	local job = xPlayer.job.name
	local grade = xPlayer.job.grade

		if datajob == "police" then
				xPlayer.setJob('offpolice', 0)
			elseif datajob == "ambulance" then
				xPlayer.setJob('offambulance', 0)
		end
end)
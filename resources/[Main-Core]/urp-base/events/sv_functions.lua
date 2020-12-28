URPCore.Trace = function(str)
	if Config.EnableDebug then
		print('URPCore> ' .. str)
	end
end

URPCore.SetTimeout = function(msec, cb)
	local id = URPCore.TimeoutCount + 1

	SetTimeout(msec, function()
		if URPCore.CancelledTimeouts[id] then
			URPCore.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	URPCore.TimeoutCount = id

	return id
end

URPCore.ClearTimeout = function(id)
	URPCore.CancelledTimeouts[id] = true
end

URPCore.RegisterServerCallback = function(name, cb)
	URPCore.ServerCallbacks[name] = cb
end

URPCore.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if URPCore.ServerCallbacks[name] ~= nil then
		URPCore.ServerCallbacks[name](source, cb, ...)
	else
		print('urp-base: TriggerServerCallback => [' .. name .. '] does not exist')
	end
end

URPCore.SavePlayer = function(xPlayer, cb)
	local asyncTasks = {}
	xPlayer.setLastPosition(xPlayer.getCoords())

	-- User accounts
	for i=1, #xPlayer.accounts, 1 do
		if URPCore.LastPlayerData[xPlayer.source].accounts[xPlayer.accounts[i].name] ~= xPlayer.accounts[i].money then
			table.insert(asyncTasks, function(cb)
				MySQL.Async.execute('UPDATE user_accounts SET money = @money WHERE identifier = @identifier AND name = @name', {
					['@money']      = xPlayer.accounts[i].money,
					['@identifier'] = xPlayer.identifier,
					['@name']       = xPlayer.accounts[i].name
				}, function(rowsChanged)
					cb()
				end)
			end)

			URPCore.LastPlayerData[xPlayer.source].accounts[xPlayer.accounts[i].name] = xPlayer.accounts[i].money
		end
	end
	
	-- Job, loadout and position
	table.insert(asyncTasks, function(cb)
		MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade, loadout = @loadout, position = @position WHERE identifier = @identifier', {
			['@job']        = xPlayer.job.name,
			['@job_grade']  = xPlayer.job.grade,
			['@loadout']    = json.encode(xPlayer.getLoadout()),
			['@position']   = json.encode(xPlayer.getLastPosition()),
			['@identifier'] = xPlayer.identifier
		}, function(rowsChanged)
			cb()
		end)
	end)

	Async.parallel(asyncTasks, function(results)

		if cb ~= nil then
			cb()
		end
	end)
end


URPCore.SavePlayers = function(cb)
	local asyncTasks = {}
	local xPlayers   = URPCore.GetPlayers()

	for i=1, #xPlayers, 1 do
		table.insert(asyncTasks, function(cb)
			local xPlayer = URPCore.GetPlayerFromId(xPlayers[i])
			URPCore.SavePlayer(xPlayer, cb)
		end)
	end

	Async.parallelLimit(asyncTasks, 8, function(results)
		--RconPrint('\27[32m[urp-base] [Saving All Players]\27[0m' .. "\n")

		if cb ~= nil then
			cb()
		end
	end)
end

URPCore.StartDBSync = function()
	function saveData()
		URPCore.SavePlayers()
		SetTimeout(0, saveData)
	end

	SetTimeout(0, saveData)
end

URPCore.GetPlayers = function()
	local sources = {}

	for k,v in pairs(URPCore.Players) do
		table.insert(sources, k)
	end

	return sources
end


URPCore.GetPlayerFromId = function(source)
	return URPCore.Players[tonumber(source)]
end

URPCore.GetPlayerFromIdentifier = function(identifier)
	for k,v in pairs(URPCore.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

URPCore.DoesJobExist = function(job, grade)
	grade = tostring(grade)

	if job and grade then
		if URPCore.Jobs[job] and URPCore.Jobs[job].grades[grade] then
			return true
		end
	end

	return false
end
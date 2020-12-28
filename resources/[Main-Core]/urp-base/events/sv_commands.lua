TriggerEvent('es:addGroupCommand', 'setjob', 'admin', function(source, args, user)
	print("running this shit")
	if tonumber(args[1]) and args[2] and tonumber(args[3]) then
		local xPlayer = URPCore.GetPlayerFromId(args[1])

		if xPlayer then
			if URPCore.DoesJobExist(args[2], args[3]) then
				xPlayer.setJob(args[2], args[3])
			else
				TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'That job does not exist.')
			end

		else
			TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'Player not online.')
		end
	else
		TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'Invalid usage.')
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'Insufficient Permissions.')
end, {help = _U('setjob'), params = {{name = "id", help = _U('id_param')}, {name = "job", help = _U('setjob_param2')}, {name = "grade_id", help = _U('setjob_param3')}}})

TriggerEvent('es:addGroupCommand', 'giveaccountmoney', 'admin', function(source, args, user)
	local _source = source
	local xPlayer = URPCore.GetPlayerFromId(args[1])
	local account = args[2]
	local amount  = tonumber(args[3])

	if amount ~= nil then
		if xPlayer.getAccount(account) ~= nil then
			xPlayer.addAccountMoney(account, amount)
		else
			TriggerClientEvent('urp:showNotification', _source, _U('invalid_account'))
		end
	else
		TriggerClientEvent('urp:showNotification', _source, _U('amount_invalid'))
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'Insufficient Permissions.')
end, {help = _U('giveaccountmoney'), params = {{name = "id", help = _U('id_param')}, {name = "account", help = _U('account')}, {name = "amount", help = _U('money_amount')}}})

TriggerEvent('es:addGroupCommand', 'clear', 'user', function(source, args, user)
	TriggerClientEvent('chat:clear', source)
end, function(source, args, user)
	TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'Insufficient Permissions.')
end, {help = _U('chat_clear')})

TriggerEvent('es:addGroupCommand', 'clearall', 'admin', function(source, args, user)
	TriggerClientEvent('chat:clear', -1)
end, function(source, args, user)
	TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'Insufficient Permissions.')
end, {help = _U('chat_clear_all')})

TriggerEvent('es:addGroupCommand', 'tp', 'admin', function(source, args, user)
	local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
	
	if x and y and z then
		TriggerClientEvent('urp:teleport', source, {
			x = x,
			y = y,
			z = z
		})
	else
		TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'Invalid coordinates.')
	end
	end, function(source, args, user)
		TriggerClientEvent('chatMessagess', source, 'SYSTEM: ', 3, 'Insufficient Permissions.')
	end, {help = "Teleport to coordinates", params = {{name = "x", help = "X coords"}, {name = "y", help = "Y coords"}, {name = "z", help = "Z coords"}}})
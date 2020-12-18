NPX.DB = NPX.DB or {}
NPX.Player = NPX.Player or {}

NPX.DB.LoadCharacter = function(source, id)
	local src = source

	TriggerEvent('np-base:loadPlayer', id)
end


NPX.DB.doesUserExist = function(id, callback) 
	TriggerEvent('np-base:doesExist', id, callback)
end

NPX.DB.SavePlayer = function(source, id, bank, cash)
	exports.ghmattimysql:execute("UPDATE characters SET bank, cash, job WHERE id)", {
        ['@id'] = id,
		['@bank'] = bank,
		['cash'] = cash,
		['job'] = job
    })
	print('[^2NPX^0] ' .. GetPlayerName(source) .. ' was saved successfully!' .. 'CID = ' .. id .. 'bank = ' .. bank .. 'cash = ' .. cash .. 'job = ' .. job)
end



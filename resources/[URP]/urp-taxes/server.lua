URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj)
	URPCore = obj
end)

local TodayDay = (os.date('%d'))
local LastProcessDay, Hour

local ClassTable = {}
for k=1, #Config.Class, 1 do
	table.insert(ClassTable, Config.Class[k].limit)
end

Citizen.CreateThread(function()
	while true do
		Hour = (os.date('%H'))
		
		if TodayDay ~= LastProcessDay then
			if Hour == tostring(Config.TaxTime) then
				MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `bank` + `money` > @LowIncome',
				{
					['@LowIncome']  = Config.LowIncome
				},function(result)
					for i=1, #result, 1 do
						assets = result[i].bank + result[i].money
						taxes = NearestValue(ClassTable, assets)
						
						if taxes ~= 0 then
							xPlayer = URPCore.GetPlayerFromIdentifier(result[i].identifier)
							xTaxesReduce = (result[i].bank + result[i].money) * taxes / 100
														
							if xPlayer then
								xPlayer.removeAccountMoney('bank', xTaxesReduce)
								TriggerClientEvent('DoLongHudText', source, "You have paid your taxes", 2)								
							else
								MySQL.Sync.execute('UPDATE `users` SET `bank` = bank - @bank WHERE  `identifier` = @identifier',
								{
									['@bank']       = xTaxesReduce,
									['@identifier'] = result[i].identifier
								})
							end
						end
					end
				end)
				LastProcessDay = (os.date('%d'))
			end
		end
		
		Citizen.Wait(60 * 1000 * 5)
	end
end)

function NearestValue(table, number)
    local smallest, smallestResult
	
    for i, y in ipairs(table) do
		if (not smallest or (math.abs(number-y) < smallest)) and number > i then
            smallest = math.abs(number-y)
            smallestResult = i
        end
    end
	
    return smallestResult
end
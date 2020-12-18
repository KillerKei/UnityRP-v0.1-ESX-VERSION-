local weapons = ""
local playerInjury = {}
local bones = {}

URPCore = nil

TriggerEvent('urp:getSharedObject', function(obj) URPCore = obj end)


RegisterServerEvent("police:showID")
AddEventHandler("police:showID", function(data)
	local src = source
	local xPlayer = URPCore.GetPlayerFromId(src)
	local identifier = xPlayer.identifier
	local info = json.decode(data)
	print('gender',info.Sex)
	local info = {
		status = 1,
		Name = info.Firstname,
		Surname = info.Lastname,
		DOB = info.DOB,
		sex = info.Sex,
		identifier = info.cid
	}
	print(cid)
	TriggerClientEvent('urp-rpchat:showId', -1, '<div style="padding: 0.475vw; padding-left: 0.8vw; padding-right: 0.7vw; margin: 0.1vw; background-color: rgba(190, 97, 18, 0.6); border-radius: 10px 10px 10px 10px;"><span style="font-weight: bold;">Citizen Card: </span>' .. info.Name ..' ' .. info.Surname ..' |&nbsp;<span style="font-weight: bold;">DOB: </span> ' .. info.DOB .. ' |&nbsp;<span style="font-weight: bold;">Gender: </span> ' .. info.sex .. ' |&nbsp;<span style="font-weight: bold;">Citizen ID: </span> ' .. info.identifier .. '  </div>', src)
end)

RegisterServerEvent('server:takephone')
AddEventHandler('server:takephone', function(target)
    TriggerClientEvent('inventory:removeItem', target, "mobilephone", 1)
end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(player)
	TriggerClientEvent('playerTackled', player)
	TriggerClientEvent('playerTackled', source)
end)


RegisterServerEvent('dragPlayer:disable')
AddEventHandler('dragPlayer:disable', function()
	TriggerClientEvent('drag:stopped', -1, source)
end)

RegisterServerEvent('dr:releaseEscort')
AddEventHandler('dr:releaseEscort', function(releaseID)
	TriggerClientEvent('dr:releaseEscort', tonumber(releaseID))
end)

RegisterServerEvent('police:remmaskGranted')
AddEventHandler('police:remmaskGranted', function(targetplayer)
    TriggerClientEvent('police:remmaskAccepted', targetplayer)
end)

RegisterServerEvent('unseatAccepted')
AddEventHandler('unseatAccepted', function(targetplayer,x,y,z)
    TriggerClientEvent('unseatPlayerFinish', targetplayer,x,y,z)
end)

RegisterServerEvent('police:updateLicenses')
AddEventHandler('police:updateLicenses', function(targetlicense, status, license)
    if status == 1 then
        TriggerEvent('urp-license:addLicense', targetlicense, license)
    else
        TriggerEvent('urp-license:removeLicense', targetlicense, license)
    end
end)


--- POLICE SEXTION -------------------------------

RegisterServerEvent('police:cuffGranted2')
AddEventHandler('police:cuffGranted2', function(t,softcuff)
	local src = source
    
	print('cuffing')
	TriggerClientEvent('menu:setCuffState', t, true)
	TriggerEvent('police:setCuffState2', t, true)
	if softcuff then
        TriggerClientEvent('handCuffedWalking', t)
        print('softcuff')
    else
        print('hardcuff')
		TriggerClientEvent('police:getArrested2', t, src)
		TriggerClientEvent('police:cuffTransition',src)
	end
end)

RegisterServerEvent('police:cuffGranted')
AddEventHandler('police:cuffGranted', function(t)
local src = source
	TriggerEvent('police:setCuffState', t, true)
	TriggerClientEvent('menu:setCuffState', t, true)
	TriggerClientEvent('police:getArrested', t, src)
	TriggerClientEvent('police:cuffTransition',src)
end)

RegisterServerEvent('police:escortAsk')
AddEventHandler('police:escortAsk', function(target)
local xPlayer = URPCore.GetPlayerFromId(source)
	TriggerClientEvent('dr:escort', target,source)
end)

RegisterServerEvent('falseCuffs')
AddEventHandler('falseCuffs', function(t)
	TriggerClientEvent('falseCuffs',t)
	TriggerClientEvent('menu:setCuffState', t, false)
end)

RegisterServerEvent('police:setCuffState')
AddEventHandler('police:setCuffState', function(t,state)
	TriggerClientEvent('police:currentHandCuffedState',t,true)
	TriggerClientEvent('menu:setCuffState', t, true)
end)

RegisterServerEvent('police:forceEnterAsk')
AddEventHandler('police:forceEnterAsk', function(target,netid)
local xPlayer = URPCore.GetPlayerFromId(source)
	TriggerClientEvent('police:forcedEnteringVeh', target, netid)
	TriggerClientEvent('DoLongHudText', source, 'Seating Player', 1)
end)

--- POLICE SEXTION ^^^^^^^^^^^^


RegisterServerEvent('ped:forceTrunkAsk')
AddEventHandler('ped:forceTrunkAsk', function(targettrunk)
TriggerClientEvent('ped:forcedEnteringVeh', targettrunk)
end)

RegisterServerEvent('Evidence:GiveWoundsFinish')
AddEventHandler('Evidence:GiveWoundsFinish', function(data, databone)
    playerInjury[source] = data
    bones[source] = databone
end)

RegisterServerEvent('bones:server:updateServer')
AddEventHandler('bones:server:updateServer', function(data2)
    bones[source] = data2
	print('printing bones data ', bones[source])
	TriggerClientEvent('bones:client:updatefromDB', source, data2)
end)

RegisterServerEvent('government:bill')
AddEventHandler('government:bill', function(data)
	local xPlayer = URPCore.GetPlayerFromId(source)
	TriggerEvent('urp-core:removeCash', source, data)
end)

RegisterServerEvent('sniffAccepted')
AddEventHandler('sniffAccepted', function(data)
	TriggerClientEvent('K9:SniffConfirmed', source)
end)

RegisterServerEvent('reviveGranted')
AddEventHandler('reviveGranted', function(t)
	TriggerClientEvent('reviveFunction', t)
end)

RegisterServerEvent('ems:stomachpumptarget')
AddEventHandler('ems:stomachpumptarget', function(t)
TriggerClientEvent('fx:stomachpump', t)
end)

RegisterServerEvent('ems:healplayer')
AddEventHandler('ems:healplayer', function(t)
TriggerClientEvent('healed:minors', t)
end)

RegisterServerEvent('huntAccepted')
AddEventHandler('huntAccepted', function(player, distance, coords)
TriggerClientEvent('K9:HuntAccepted', player, coords, distance)
end)
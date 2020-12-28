RegisterServerEvent('urp-cid:createID')
AddEventHandler('urp-cid:createID', function(first, last, job, sex, dob)
    print("yeah i got triggered")
    information = {
        ["cid"] = "Unknown",
        ["Firstname"] = tostring(first),
        ["Lastname"] = tostring(last),
        ["Sex"] = tostring(sex),
        ["DOB"] = tostring(dob),
    }
    TriggerClientEvent("player:receiveItem",source,"idcard",1,true,information)
end)

RegisterServerEvent('quitto')
AddEventHandler('quitto', function()
DropPlayer(source, "The Player Has Disconnected. (Related to ID Card)")
end)
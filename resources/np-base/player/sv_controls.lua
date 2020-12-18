RegisterServerEvent("np-base:sv:player_control_set")
AddEventHandler("np-base:sv:player_control_set", function(controlTable)
	local src = source
	NPX.DB:UpdateControls(src,controlTable,function(updatedControls, err)
		if updatedControls then
			-- we are good here.
		end
	end)
end)

RegisterServerEvent("np-base:sv:player_control")
AddEventHandler("np-base:sv:player_control", function()
	local src = source
	NPX.DB:GetControls(src,function(LoadedControls, err)
		if loadedControls ~= nil then TriggerClientEvent("np-base:cl:player_control",src,json.decode(loadedControls)) else TriggerClientEvent("np-base:cl:player_control",src,nil) end
	end)
end)

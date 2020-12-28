AddEventHandler('urp:getSharedObject', function(cb)
	cb(URPCore)
end)

function getSharedObject()
	return URPCore
end

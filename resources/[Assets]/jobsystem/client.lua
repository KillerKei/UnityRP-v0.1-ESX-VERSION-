local PlayerData = {}
URPCore = nil

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

RegisterNetEvent('urp:playerLoaded')
AddEventHandler('urp:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('urp:setJob')
AddEventHandler('urp:setJob', function(job)
	PlayerData.job = job
	onDuty = false
	myPlate = {} -- loosing vehicle caution in case player changes job.
	spawner = 0
end)

---------------------------------- VAR ----------------------------------
isCop = false
curJob = nil

local changeYourJob = {
  {name="Job Center", colour=17, id=351, x=-1081.8293457031, y=-248.12872314453, z=37.763294219971},
}

local jobs = {
  {name="Unemployed", id="unemployed"},
  {name="Tow Truck Driver", id="towtruck"},  
  {name="Taxi Driver", id="taxi"},
  {name="Delivery Job", id="trucker"},
  {name="Entertainer", id = "entertainer"},
  {name="News Reporter", id = "news"},
  {name="Food Truck", id = "foodtruck"},
    --{name="EMS", id="ems"},
}

---------------------------------- FUNCTIONS ----------------------------------

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

function menuJobs()
  ClearMenu()


  for _, item in pairs(jobs) do
    local nameJob = item.name
    local idJob = item.id
    Menu.addButton(nameJob,"SetJob",idJob)
  end

  Menu.addButton('Exit',"SetJob",'exit')


end

function SetJob(job)
  if job == 'exit' then
    ClearMenu()
  else
    TriggerServerEvent('jobsystem:Job', job)
  end
end

local zones = {
  vector3(-139.07, -632.17, 167.82)
}

-- #MarkedForMarker
Citizen.CreateThread(function()
  
  while true do
    Citizen.Wait(0)
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for k,v in pairs(zones) do
      local dist = Vdist2(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z)
      if dist < 40 then
        DrawMarker(27,v.x,v.y,v.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0) 
        if dist < 5 then
        drawTxt('~b~[E]~s~ Job Center',0,1,0.5,0.8,0.35,255,255,255,255)
          if IsControlJustPressed(0, 38) then
            menuJobs()
            Menu.hidden = not Menu.hidden 
          end
        end
      else
        Citizen.Wait(1000)
        ClearMenu()
        Menu.hidden = true
      end
    end

    Menu.renderGUI()
  end
end)

Citizen.CreateThread(function()
local insideCentre = { x = -137.2746887207, y = -623.98498535156, z = 168.8203125 }
local outsideCentre = { x = 172.78, y = -26.89, z = 68.35 }
  while true do
   Citizen.Wait(1)
   local plyId = PlayerPedId()
   local plyCoords = GetEntityCoords(plyId)
   local dstOffice = #(plyCoords - vector3(172.78, -26.89, 68.35))
   local dstOfficeExit = #(plyCoords - vector3(-137.274, -623.98, 168.82))

   if dstOffice < 3.0 then
    DrawText3Ds( 172.78, -26.89, 68.35, '[E] Enter Job Centre' )
    if IsControlJustReleased(0, Keys['E']) then
      URPCore.Game.Teleport(PlayerPedId(), insideCentre)
    end
   elseif dstOfficeExit < 3.0 then
    DrawText3Ds( -137.2746887207, -623.98498535156, 168.8203125, '[E] Exit Job Centre' )

    if IsControlJustReleased(0, Keys['E']) then
      URPCore.Game.Teleport(PlayerPedId(), outsideCentre)
    end
   else
     if dstOffice > 100.0 then
       Citizen.Wait(2000)
     end
   end
 end
end)

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()

  local blip = AddBlipForCoord(vector3(172.78,-26.89,68.35))

  SetBlipSprite (blip, 457)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, 47)
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Job Center')
  EndTextCommandSetBlipName(blip)

end)
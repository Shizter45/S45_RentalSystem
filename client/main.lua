RegisterNetEvent('S45_Rental:RentVehicle')
AddEventHandler('S45_Rental:RentVehicle', function(data)
  print('Button works')
  spawnCar(data.veh, vector3(331.7, 3385.68, 36.4), 111.02)
end)

RegisterNetEvent('S45_rental:SandyReturn')
AddEventHandler('S45_rental:SandyReturn', function(veh)
  print(tostring(veh))
  print('Vehicle Delete')
  -- DeleteVehicle(veh)
  TriggerEvent('chat:addMessage', {
    color = {6, 224, 49},
    multiline = true,
    args = {'Sandy Rental', 'Thanks for Returning your vehicle'}
  })
end)

---- Blip and Marker Logic ----
Citizen.CreateThread(function()
    blip = AddBlipForCoord(Config.SandyLocs.x, Config.SandyLocs.y, Config.SandyLocs.z)
    SetBlipSprite(blip, Config.SandyBlip)
    SetBlipColour(blip, Config.SandyBlipColor)
    SetBlipDisplay(blip, 6)
    SetBlipScale(blip, Config.SandyBlipScale)
    AddTextEntry('SANDY', 'Sandy Shores Offroad Rental')
    BeginTextCommandSetBlipName('SANDY')
    SetBlipCategory(blip, 2)
    EndTextCommandSetBlipName(blip)
    print('Blip Init: '..blip)
end)

Citizen.CreateThread(function()

	while true do
    Wait(0)
    DrawMarker(Config.SandyMarker, Config.SandyLocs.x, Config.SandyLocs.y, Config.SandyLocs.z-1, 0.0, 0.0, 0.0,0.0,0.0,0.0, 1.0,1.0,1.0, Config.SandyMarkerColor.r, Config.SandyMarkerColor.g, Config.SandyMarkerColor.b, Config.SandyMarkerColor.a, false, true, 2, false, nil, nil, false)
		local playerCoords = GetEntityCoords(PlayerPedId())

		-- Check the markers
    while #(GetEntityCoords(PlayerPedId()) - Config.SandyLocs) <= 1.0 do
      Wait(0)
      help('Press ~b~[E]~w~ to Rent a Vehicle')
      if IsControlJustReleased(0, 51) then
        TriggerEvent('S45_rental:Sandy')
      end
    end
	end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    while #(GetEntityCoords(PlayerPedId()) - Config.SandyRentalReturn) <= 3.0 do
      Wait(0)
      local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
      if vehicle == 0 then
        return
      else
        help('Press ~b~[E]~w~ to Return Rental Vehicle')
        if IsControlJustPressed(0, 51) then
          DeleteVehicle(vehicle)
          print('Vehicle Delete')
        end
      end
    end
  end
end)

RegisterCommand('dv', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  DelVeh(vehicle)
end)
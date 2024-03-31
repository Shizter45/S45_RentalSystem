function spawnCar(veh, coords, heading)

  local car = GetHashKey(veh)

  RequestModel(car)
  while not HasModelLoaded(car) do
    RequestModel(car)
    Wait(50)
  end

  local vehicle = CreateVehicle(car, coords, heading, true, false)
  SetPedIntoVehicle(PlayerPedId(), vehicle, -1)

  SetEntityAsMissionEntity(vehicle, true, true)
  SetEntityAsNoLongerNeeded(vehicle)
  SetModelAsNoLongerNeeded(veh)
end

function help(msg)
  BeginTextCommandDisplayHelp("THREESTRINGS") -- DON'T CHANGE THIS
  AddTextComponentSubstringPlayerName(msg)
  EndTextCommandDisplayHelp(0, false, false, 0)
end

local QBCore = exports['qb-core']:GetCoreObject()

BlipLocations = {
    [1] = {
        coords = vector3(-163.53, -2130.0, 16.7),
        sprite = 523,
        scale = 0.7,
        color = 2,
    }
}

FuelScript = 'LegacyFuel' --change this to your fuel script export / ps-fuel / lj-fuel / ps-fuel

CreateThread(function()
    for _, value in pairs(BlipLocations) do
        local blip = AddBlipForCoord(value.coords.x, value.coords.y, value.coords.z)
        SetBlipSprite(blip, value.sprite)
        SetBlipScale(blip, value.scale)
        SetBlipColour(blip, value.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Go Kart')
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('aalbonn-kart:SpawnVeto', function() 
    local coords = vector4(-163.32, -2134.72, 16.7, 291.63)
    QBCore.Functions.SpawnVehicle('veto', function(veh)
        QBCore.Functions.Notify('Kart 1 Spawned', 'success', 5000)
        SetVehicleNumberPlateText(veh, math.random(1, 99999999))
        SetEntityHeading(veh, coords.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        exports[FuelScript]:SetFuel(veh, 100.0)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

RegisterNetEvent('aalbonn-kart:SpawnVeto2', function() 
    local coords = vector4(-162.16, -2138.49, 16.7, 294.59)
    QBCore.Functions.SpawnVehicle('veto2', function(veh)
        QBCore.Functions.Notify('Kart 2 Spawned', 'success', 5000)
        SetVehicleNumberPlateText(veh, math.random(1, 99999999))
        SetEntityHeading(veh, coords.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        exports[FuelScript]:SetFuel(veh, 100.0)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

RegisterNetEvent('aalbonn-kart:DeleteKarting', function() 
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    local pcoords = GetEntityCoords(ped)
    local vehicles = GetGamePool('CVehicle')
    for k, v in pairs(vehicles) do
        if #(pcoords - GetEntityCoords(v)) <= 3.0 then
            QBCore.Functions.DeleteVehicle(v)
            QBCore.Functions.Notify('Vehicle Stored', 'success')
        end
    end
end)

RegisterNetEvent('aalbonn-kart:VehicleMenu', function()
    QBCore.Functions.GetPlayerData(function (PlayerData)
        if PlayerData.job.onduty then
            exports['qb-menu']:openMenu({
                {
                    header = 'Kart Garage',
                    isMenuHeader = true, 
                },
                {
                    header = 'Open Kart Garage',
                    params = {
                        event = 'aalbonn-kart:Garage'
                    }
                },
                {
                    header = 'Store Kart',
                    params = {
                        event = 'aalbonn-kart:DeleteKarting'
                    }
                },
                {
                    header = '❌ | Close', 
                    params = {
                        event = 'qb-menu:closeMenu',
                    }
                },
            })
        else
            QBCore.Functions.Notify('You are not on duty!', 'error')
        end
    end)
end)

RegisterNetEvent('aalbonn-kart:Garage', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Kart Garage',
            isMenuHeader = true, 
        },
        {
            header = 'Kart 1',
            txt = 'Classic Karting',
			params = {
                event = 'aalbonn-kart:SpawnVeto'
            }
        },
        {
            header = 'Kart 2',
            txt = 'Modern Karting',
			params = {
                event = 'aalbonn-kart:SpawnVeto2'
            }
        },
        {
            header = '<- Go Back', 
            txt = 'Back to Menu',
            params = {
                event = 'aalbonn-kart:VehicleMenu'
            }
        },
		{
            header = '❌ | Close',
            params = {
                event = 'qb-menu:closeMenu',
            }
        },
    })
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('Karting Garage', vector3(-163.31, -2129.63, 16.71), 1.6, 0.2, {
        name = 'Karting Garage',
        heading=290,
        debugPoly = false,
        minZ=14.7,
        maxZ=18.7
    }, {
        options = {
            {
                type = 'client',
                event = 'aalbonn-kart:VehicleMenu',
                icon = 'fa fa-car',
                label = 'Open Karting Garage',
                job = 'karting',
            },
        },
        distance = 2.5
    })

    exports['qb-target']:AddBoxZone('ToggleDuty', vector3(-156.1, -2126.41, 16.75), 1.8, 1.2, {
        name = 'Toggle Duty',
        heading = 15.0,
        debugPoly = false,
        minZ=16.0,
        maxZ=17.0,
    }, {
        options = {
            {
                type = 'server',
                event = 'QBCore:ToggleDuty',
                icon = 'fas fa-clipboard',
                label = 'Toggle Duty',
                job = 'karting',
            },
        },
        distance = 2.5
    })
end)

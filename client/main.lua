local QBCore = exports['qb-core']:GetCoreObject()

local function policeAlert()
    if Config.Dispatch == 'cd' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = data.coords,
            title = '10-14 - Property Damage',
            message = 'A ' .. data.sex .. 'is damaging property at' .. data.street,
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = '911 - Property Damage',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.Dispatch == 'default' then
            TriggerServerEvent("police:server:PoliceAlert", 'Parking Meter Robbery')
    elseif Config.Dispatch == 'ps' then
        exports['ps-dispatch']:SuspiciousActivity()
    elseif Config.Dispatch == 'other' then
        -- insert your dispatch here
    end
end

--[[local function delPmeter()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, false)
    for _, v in pairs(Config.ModelHashes) do
        local closestPark = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 1.5, v, false, false, false)
        if DoesEntityExist(closestPark) then
            SetEntityAsMissionEntity(closestPark, true, true)
            DeleteEntity(closestPark)
        end
    end
end]]


local function main()
    local ped = PlayerPedId()
    local ped = source
    if IsPedInAnyVehicle(PlayerPedId())
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        if vehicle = true then
            TriggerEvent('QBCore:Notify', src, "You can't do that right now")
            end
            if vehicle = false then 
            end
    if exports['ps-inventory']:HasItem('lockpick') then
        exports['ps-ui']:Circle(function(success)
            if success then
                QBCore.Functions.Progressbar('rob_meter', 'Robbing a Parking Meter', 15000, false, true, {
                                                --Name, Label, Time, Use While Dead, Can Cancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
                },{
                    animDict = 'anim@gangops@facility@servers@',
                    anim = 'hotwire',
                    flags = 16,
                }, {}, {}, function()
                    TriggerServerEvent('wo-parknmeter-pay')
                    ClearPedTasks(ped)
                    TriggerServerEvent('wo-parknmeter:server:end')
                    policeAlert()
                    --delPmeter()
                if  Config.Cash == 'markedbills' then
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["markedbills"], "add")
                    end
                if  Config.Cash == 'dirtymoney' then
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["dirtymoney"], "add")
                    end
                if  Config.Cash == 'blackmoney' then
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["blackmoney"], "add")
                    end
                end, function()
                    ClearPedTasks(ped)
                    Citizen.Wait(30000)
                end) 
   
            else    
                QBCore.Functions.Notify('You broke the lockpick', 'error', 15000)
                TriggerServerEvent('wo-parknmeter:server:end')
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["lockpick"], "remove", 1)
                policeAlert()
                Citizen.Wait(15000)
            end   
        end, 3, 10) -- NumberOfCircles, MS 
            else
                    QBCore.Functions.Notify("You don't have the right tools", 'error', 3000)
                end
            end
            

        CreateThread(function()
            exports['qb-target']:AddTargetModel(Config.Models, {
                options = {
                    { 
                        action = function()
                            main()
                        end,
                        icon = "fas fa-screwdriver",
                        label = "Rob Parking Meter",
                    },
                },
                distance = 1.5 
            })
        end)


local QBCore = exports['qb-core']:GetCoreObject()

local function policeAlert()
    if Config.Dispatch == 'default' then
        TriggerServerEvent("police:server:PoliceAlert", 'Parking Meter Robbery')
    elseif Config.Dispatch == 'cd' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = data.coords,
            title = '10-15 - Theft In Progress',
            message = 'A ' .. data.sex .. ' committing theft at ' .. data.street,
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = '911 - Petty Theft',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.Dispatch == 'ps' then
        exports['ps-dispatch']:SuspiciousActivity()
    elseif Config.Dispatch == 'other' then
        -- insert your dispatch here
    end
end

local function delPmeter()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, false)
    for _, v in pairs(Config.ModelHashes) do
        local closestPark = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 1.5, v, false, false, false)
        if DoesEntityExist(closestPark) then
            SetEntityAsMissionEntity(closestPark, true, true)
            DeleteEntity(closestPark)
        end
    end
end

local function main()
    local ped = PlayerPedID()
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
                    TriggerServerEvent('wo-parknmeter:server:end', "lockpick", 1)
                    TriggerEvent(exports['ps-inventory']:RemoveItem('lockpick',1))
                    policeAlert()
                    delPmeter()
                    
                    if Config.Cash = 'markedbills' then
                        TriggerEvent(exports['ps-inventory']:AddItem('markedbills', 'add'))
                    end
                    if Config.Cash = 'dirtymoney' then
                        TriggerEvent(exports['ps-inventory']:AddItem('dirtymoney', 'add'))
                    end
                    if config.Cash = 'blackmoney' then
                        TriggerEvent(exports['ps-inventory']:AddItem('blackmoney', 'add'))
                    end
                end, function()
                    ClearPedTasks(ped)
                end)
            else
                QBCore.Functions.Notify('You broke the lockpick', 'error', 7500)
                TriggerServerEvent('wo-parknmeter:server:end')
                TriggerEvent(exports['ps-inventory']:RemoveItem('lockpick', 1))
                policeAlert()
            end
        else
                QBCore.Functions.Notify("You don't have the right equipment", 'error', 7500)
            end
        end, 3, 15) -- NumberOfCircles, MS

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

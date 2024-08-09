local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('wo-parknmeter:server:end', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = 'lockpick'
    local amount = 1
    exports['ps-inventory']:RemoveItem(item, amount)
end)

local function giveReward(src, itemType, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    local success
    if itemType == 'cash' then
        success = Player.Functions.AddMoney('cash', amount)
        if success then
            TriggerClientEvent('QBCore:Notify', src, 'You stole $' .. amount .. ' successfully!')
        else
            print(('Error: Failed to add money to player %d'):format(src))
            TriggerClientEvent('QBCore:Notify', src, 'Error: Failed to add money', 'error')
        end
    else
        success = exports['ps-inventory']:AddItem(src, itemType, amount)
        if success then
            TriggerClientEvent('QBCore:Notify', src, 'You stole ' .. amount .. ' ' .. itemType .. ' successfully!')
        else
            print(('Error: Failed to add item %s to player %d'):format(itemType, src))
            TriggerClientEvent('QBCore:Notify', src, 'Error: Failed to add item', 'error')
        end
    end
end
RegisterNetEvent('wo-parknmeter-pay', function()
    local src = source
    local amount = math.random(Config.Payout.min, Config.Payout.max)
    if Config.Cash == 'cash' then
        giveReward(src, 'cash', amount)
    elseif Config.Cash == 'markedbills' then
        giveReward(src, 'markedbills', amount)
    elseif Config.Cash == 'blackmoney' then
        giveReward(src, 'blackmoney', amount)
    end
end)


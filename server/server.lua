local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('wo-parknmeter:server:end', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    exports['ps-inventory']:RemoveItem('lockpick', 1)
end)

RegisterNetEvent('wo-parknmeter-pay', function()
if  Config.Cash == 'cash' then
    local amount = math.random(Config.Payout.min, Config.Payout.max)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', amount)
    TriggerClientEvent('QBCore:Notify', src, 'You stole $'..amount..'from the parking meter!', 'sucess')
end
if Config.Cash == 'markedbills' then
    local amount = math.random(Config.Payout.min, Config.Payout.max)
    local src = source
    local Player = QbCore.Functions.GetPlayer(src)
    exports['ps-inventory']:AddItem('markedbills', amount)
    TriggerClientEvent('QBCore:Notify', src, 'You stole'..amount..' of marked bills from the parking meter!', 'sucess')
end
if  Config.Cash == 'blackmoney' then
    local amount = math.random(Config.Payout.min, Config.Payout.max)
    local src = source
    local Player = QbCore.Functions.GetPlayer(src)
    exports['ps-inventory']:AddItem('blackmoney', amount)
    TriggerClientEvent('QBCore:Notify', src, 'You stole'..amount..' of black money from the parking meter!', 'sucess')
end
if  Config.Cash == 'dirtymoney' then
    local amount = math.random(Config.Payout.min, Config.Payout.max)
    local src = source
    local Player = QbCore.Functions.GetPlayer(src)
    exports['ps-inventory']:AddItem('dirtymoney', amount)
    TriggerClientEvent('QBCore:Notify', src, 'You stole'..amount..' of dirty money from the parking meter!', 'sucess')
end

end)


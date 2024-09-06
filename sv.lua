local Jomidar = exports[J0.Core]:GetCoreObject()
local lastHeistTime = 0 
--- callback
Jomidar.Functions.CreateCallback('jomidar-clicklover:sv:checkTime', function(source, cb)
    local src = source
    local player = Jomidar.Functions.GetPlayer(src)
    
    local currentTime = os.time()
    local timeSinceLastHeist = currentTime - lastHeistTime
    
    if timeSinceLastHeist < J0.CoolDown and lastHeistTime ~= 0 then
        local secondsRemaining = J0.CoolDown - timeSinceLastHeist
        local minutesRemaining = math.floor(secondsRemaining / 60)
        local remainingSeconds = secondsRemaining % 60

        TriggerClientEvent('QBCore:Notify', src, "You must wait " .. minutesRemaining .. " min and " .. remainingSeconds .. " sec before starting another work.", "error")
        cb(false)
    else
        lastHeistTime = currentTime
        cb(true)
    end
end)
-- trigger
RegisterNetEvent('jomidar:clicklover:removeItem', function(item, ammount)
    local src = source
    local Player = Jomidar.Functions.GetPlayer(src)
    if Player then
    Player.Functions.RemoveItem(item, ammount)
    TriggerClientEvent('inventory:client:ItemBox', src, Jomidar.Shared.Items[item], "remove")
    end
end)

RegisterNetEvent('jomidar:clicklover:addItem', function(item, ammount)
    local src = source
    local Player = Jomidar.Functions.GetPlayer(src)
    if Player then
    Player.Functions.AddItem(item, ammount)
    TriggerClientEvent('inventory:client:ItemBox', src, Jomidar.Shared.Items[item], "add")
    end
end)

RegisterNetEvent('jomidar:clicklover:addmoney', function(amount)
    local src = source
    local Player = Jomidar.Functions.GetPlayer(src)
    if Player then
    Player.Functions.AddMoney('cash', J0.Ammount, 'jomidar-addmoney')
    TriggerClientEvent('QBCore:Notify', src, "Great Job You Got"..amount.."$", "success")
    end
end)
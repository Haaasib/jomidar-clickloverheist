local Jomidar = exports[J0.Core]:GetCoreObject()
------- functions 


local function heistStarted()
    exports['skillchecks']:startWordsGame(10000, 10, function(success)
        if success then
            exports['jomidar-ui']:Show("Click Lovers Heist","Go outside and loot the the store")
            exports.interact:RemoveInteraction('myCoolUniqueId1')
            for k, lootCoord in pairs(J0.LootCoords) do
                local interactionID = 'lootInteraction_' .. k

                exports.interact:AddInteraction({
                    coords = lootCoord,  
                    distance = 4.0,  
                    interactDst = 2.0,  
                    id = interactionID, 
                    name = 'LootInteraction ' .. k,
                    options = {
                        {
                            label = 'Loot Item',  -- Displayed option
                            action = function(entity, coords, args)
                                Jomidar.Functions.Progressbar("random_task", "Youre Looting....", 5000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = true,
                                    disableCombat = true,
                                 }, {
                                    animDict = "missheist_jewel",
                                    anim = "smash_case",
                                    flags = 49,
                                 }, {}, {}, function()
                                    exports['jomidar-ui']:Close()
                                    local randomIndex = math.random(1, #J0.Lootitems)
                                    local randomItem = J0.Lootitems[randomIndex]
                                    print(randomItem)
                                    TriggerServerEvent('jomidar:clicklover:addItem', randomItem.name, randomItem.quantity)
                                    exports.interact:RemoveInteraction(interactionID)
                                 end, function()
                                 
                                 end)
                            end,
                        },
                    }
                })
            end
        else
            Jomidar.Functions.Notify("You Failed, Try again!", "error")  
        end
    end) 
end
local function breakdoor()
    exports['jomidar-ui']:Show("Click Lovers Heist", "Go inside of Click Lovers and break the door")
    exports.interact:AddInteraction({
        coords = vector3(211.2, -1507.63, 29.29),
        distance = 4.0, -- optional
        interactDst = 2.0, -- optional
        id = 'clicklover2', -- needed for removing interactions
        name = 'clicklover2', -- optional
        options = {
            {
                label = 'Break The Door',
                action = function(entity, coords, args)
                    exports['skillchecks']:startWordsGame(10000, 10, function(success)
                        if success then
                            -- Load the animation dictionary for the thermite animation
                            local playerPed = PlayerPedId() -- Get the player character
                            RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
                            while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
                                Wait(100)
                            end
                            
                            TaskPlayAnim(playerPed, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 8.0, -8.0, -1, 49, 0, false, false, false)
                            Citizen.Wait(5000)
                            ClearPedTasks(playerPed)
                            
                            exports['jomidar-ui']:Show("Click Lovers Heist", "Go inside and hack the computer")
                            
                            exports.interact:AddInteraction({
                                coords = vector3(209.62, -1509.4, 29.29),
                                distance = 4.0, 
                                interactDst = 2.0, 
                                id = 'myCoolUniqueId1', 
                                name = 'interactionName1',
                                options = {
                                    {
                                        label = 'Hack Computer',
                                        action = function(entity, coords, args)
                                            heistStarted()                                                   
                                        end,
                                    },
                                }
                            })
                            exports.interact:RemoveInteraction('clicklover2')
                        else
                            Jomidar.Functions.Notify("You Failed, Try again!", "error")
                        end
                    end)
                end,
            },
        }
    })

end
-- triggers
RegisterNetEvent('jomidar:clicklover:startheist', function() 
    local hasItem = QBCore.Functions.HasItem("security_card_01", 1)
    if hasItem then
    Jomidar.Functions.TriggerCallback('jomidar-clicklover:sv:checkTime', function(time)
        if time then
            exports['skillchecks']:startUntangleGame(50000, 5, function(success)
                if success then
                    Jomidar.Functions.Progressbar("1", "Youre Hacking Click Lovers", 5000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = true,
                        disableCombat = true,
                     }, {
                        animDict = "mp_bank_heist_1",
                        anim = "hack_loop",
                        flags = 49,
                     }, {}, {}, function()
                        breakdoor()
                    end, function()
                                 
                    end)
                else
                    Jomidar.Functions.Notify("You Failed, Try again!", "error")
                end
            end)
        end
    end)
else
    Jomidar.Functions.Notify("You dont have the item", "error")

end
end)


--- threads
                       
CreateThread(function() 
    
    exports.interact:AddInteraction({
        coords = vector3(195.44, -1476.28, 29.31),
        distance = 4.0, 
        interactDst = 2.0, 
        id = 'clicklover1', 
        name = 'clicklover', 
        options = {
             {
                label = 'Start Heist',
                action = function(entity, coords, args)
                exports['jomidar-ui']:Show("Click Lovers Heist", "You are hacking Click Lovers system")
                TriggerEvent('jomidar:clicklover:startheist')
                end,
            },
        }
    })

end)

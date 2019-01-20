local NULL = -1 -- Needed to represent an empty slot because tables can't contain nil

script.on_init(function()
    global.supplytoggle = {}
end)

script.on_configuration_changed(function()
    -- Check if persistence table exists
    if global.supplytoggle == nil then
        global.supplytoggle = {}
    end
end)

script.on_event("toggle-supply",
    function(event)
        -- get char of player that fired the event
        local player = game.players[event.player_index]
        if not player then
            return
        end
    
        local char = player.character
        if not char then
            return
        end
        
        -- Exit if there are no request slots
        if char.request_slot_count == 0 then
            return
        end

        -- Set up reference to players table in global
        if global.supplytoggle[event.player_index] == nil then
            global.supplytoggle[event.player_index] = {
                ison = true,
                request_slots = {}
            }
        end
        local player_data = global.supplytoggle[event.player_index]

        if player_data.ison then
            -- Exit if there are no requested items
            local allEmpty = true
            for i = 1,char.request_slot_count do
                if char.get_request_slot(i) then
                    allEmpty = false
                    break
                end
            end
            if allEmpty then
                player.print({"message_empty"})
                return
            end
            
            -- Save and clear
            for i = 1,char.request_slot_count do
                local slot = char.get_request_slot(i)
                if slot then
                    table.insert(player_data.request_slots, slot)
                    char.clear_request_slot(i)
                else
                    table.insert(player_data.request_slots, NULL)
                end
            end
            player_data.ison = false
            player.print({"message_off"})
        else
            -- Reapply slots
            for i, slot in ipairs(player_data.request_slots) do
                if slot ~= NULL then
                    if slot.count == 0 then
                        player.print({"message_count_zero", "__ENTITY__" .. slot.name .. "__"})
                        char.clear_request_slot(i)
                    else
                        char.set_request_slot(slot, i)
                    end
                else
                    char.clear_request_slot(i)
                end
            end
            player_data.request_slots = {}
            player_data.ison = true
            player.print({"message_on"})
        end
    end
)
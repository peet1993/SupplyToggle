isOn = true
slots = {}
Null = -1 -- Needed to represent an empty slot because tables can't contain nil

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
        
        if isOn then
            -- Exit if there are no requested items
            local allEmpty = true
            for i = 1,char.request_slot_count do
                if char.get_request_slot(i) then
                    allEmpty = false
                    break
                end
            end
            if allEmpty then
                return
            end
            
            -- Save and clear
            for i = 1,char.request_slot_count do
                local slot = char.get_request_slot(i)
                if slot then
                    table.insert(slots, slot)
                    char.clear_request_slot(i)
                else
                    table.insert(slots, Null)
                end
            end
            isOn = false
            player.print({"message_off"})
        else
            -- Reapply slots
            for i, slot in ipairs(slots) do
                if slot ~= Null then
                    char.set_request_slot(slot, i)
                else
                    char.clear_request_slot(i)
                end
            end
            slots = {}
            isOn = true
            player.print({"message_on"})
        end
    end
)
local NULL = -1 -- Needed to represent an empty slot because tables can't contain nil

-- Check if all request slots are empty
function check_empty(char)
    local allEmpty = true
    for i = 1,char.request_slot_count do
        if char.get_request_slot(i) then
            allEmpty = false
            break
        end
    end

    return allEmpty
end

function toggle_shortcut(player, new_state)
    if player.is_shortcut_available("toggle-supply") then
        player.set_shortcut_toggled("toggle-supply", new_state)
    end
end

function toggle_off(player_data, player, char)
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
    toggle_shortcut(player, false)
end

function toggle_on(player_data, player, char)
    -- Clear all slots that have something in it
    -- needed if someone set one of the saved request - would be in the list twice, which is not possible
    for i = 1,char.request_slot_count do
        if char.get_request_slot(i) ~= nil then
            char.clear_request_slot(i)
        end
    end

    -- Reapply slots
    for i, slot in ipairs(player_data.request_slots) do
        if slot ~= NULL then
            if slot.count == 0 then
                player.print({"message_count_zero", "__ENTITY__" .. slot.name .. "__"})
            else
                char.set_request_slot(slot, i)
            end
        end
    end
    player_data.ison = true
    player_data.request_slots = {}
    player.print({"message_on"})
    toggle_shortcut(player, true)
end

function toggle(event)
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

    local player_data = get_player_data(event.player_index)

    if player_data.ison then
        if check_empty(char) then
            player.print({"message_empty"})
            return
        end

        toggle_off(player_data, player, char)
    else
        toggle_on(player_data, player, char)
    end
end

function modify_button_state()
    for idx, player in pairs(game.players) do
        if player.character then
            player.set_shortcut_available("toggle-supply", player.character.request_slot_count ~= 0)
            toggle_shortcut(player, get_player_data(idx).ison)
        end
    end
end

function get_player_data(index)
    if global.supplytoggle == nil then
        init_supplytoggle()
    elseif global.supplytoggle[index] == nil then
        init_player(index)
    end

    return global.supplytoggle[index]
end

function init_player(index)
    -- Set up reference to players table in global
    global.supplytoggle[index] = {
        ison = true,
        request_slots = {}
    }
end

function init_supplytoggle()
    global.supplytoggle = {}

    for idx, _ in pairs(game.players) do
        init_player(idx)
    end

    modify_button_state()
end

script.on_init(function()
    init_supplytoggle()
end
)

script.on_configuration_changed(function()
    -- Check if persistence table exists
    if global.supplytoggle == nil then
        init_supplytoggle()
    end
end
)

-- Disable request when player respawns
script.on_event({defines.events.on_player_respawned},
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

        local player_data = get_player_data(event.player_index)
        if player_data.ison then
            toggle_off(player_data, player, char)
            player.print({"message_died"})
        end
    end
)

-- toggle supply if shortcut is used
script.on_event({defines.events.on_lua_shortcut},
    function(event)
        if event.prototype_name == "toggle-supply" then
            toggle(event)
        end
    end
)

-- toggle supply if hotkey is used
script.on_event("toggle-supply", toggle)

-- Check if there are still request slots when the editor is toggled (could unresearch slots)
script.on_event({defines.events.on_player_toggled_map_editor}, modify_button_state)

-- Check if there are request slots now and enable shortcut then
script.on_event({defines.events.on_research_finished}, modify_button_state)

-- Check if a console command added/removed slots
script.on_event({defines.events.on_console_command}, modify_button_state)

-- Initialize entry for new player and set the shortcut button correctly
script.on_event({defines.events.on_player_created},
    function(event)
        init_player(event.player_index)
        modify_button_state()
    end
)
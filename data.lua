local hotkey = {
    type = "custom-input",
    name = "toggle-supply",
    key_sequence = "CONTROL + T",
    consuming = "none",
}
data:extend({hotkey})

local shortcut = {
    type = "shortcut",
    name = "toggle-supply",
    action = "lua",
    associated_control_input = "toggle-supply",
    technology_to_unlock = "character-logistic-slots-1",
    toggleable = true,
    icon = {
        filename = "__SupplyToggle__/graphics/icons/supply_32px.png",
        priority = "extra-high-no-scale",
        size = 32,
        scale = 1,
        flags = {"icon"}
    },
    small_icon = {
        filename = "__SupplyToggle__/graphics/icons/supply_24px.png",
        priority = "extra-high-no-scale",
        size = 24,
        scale = 1,
        flags = {"icon"}
    },
    disabled_icon = {
        filename = "__SupplyToggle__/graphics/icons/supply_32px_white.png",
        priority = "extra-high-no-scale",
        size = 32,
        scale = 1,
        flags = {"icon"}
    },
    disabled_small_icon = {
        filename = "__SupplyToggle__/graphics/icons/supply_24px_white.png",
        priority = "extra-high-no-scale",
        size = 24,
        scale = 1,
        flags = {"icon"}
    },
}
data:extend({shortcut})
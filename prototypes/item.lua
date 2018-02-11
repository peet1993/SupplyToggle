-- entity belt
local entity = table.deepcopy(data.raw["transport-belt"]["transport-belt"])
entity.name = "slow-transport-belt"
entity.icon = "__SlowBelt__/graphics/icons/slowbelt.png"
entity.minable.result = "slow-transport-belt"
entity.speed = entity.speed / 4

local standard = "__SlowBelt__/graphics/entity/transport-belt.png"
local hr = "__SlowBelt__/graphics/entity/hr-transport-belt.png"
entity.belt_horizontal.filename = standard
entity.belt_horizontal.hr_version.filename = hr
entity.belt_vertical.filename = standard
entity.belt_vertical.hr_version.filename = hr
entity.ending_top.filename = standard
entity.ending_top.hr_version.filename = hr
entity.ending_bottom.filename = standard
entity.ending_bottom.hr_version.filename = hr
entity.ending_side.filename = standard
entity.ending_side.hr_version.filename = hr
entity.starting_top.filename = standard
entity.starting_top.hr_version.filename = hr
entity.starting_bottom.filename = standard
entity.starting_bottom.hr_version.filename = hr
entity.starting_side.filename = standard
entity.starting_side.hr_version.filename = hr
--error(serpent.block(entity))
entity.animations.filename = standard
entity.animations.hr_version.filename = hr

entity.order = "a[transport-belt]-a[slow-transport-belt]"


-- item belt
local item = table.deepcopy(data.raw.item["transport-belt"])
item.name = "slow-transport-belt"
item.icons = {
	{
		icon="__SlowBelt__/graphics/icons/slowbelt.png",
	}
}
item.order="a[transport-belt]-a[slow-transport-belt]"
item.icon_size=32
item.stack_size=100
item.place_result="slow-transport-belt"


-- recipe belt
local recipe = table.deepcopy(data.raw.recipe["transport-belt"])
recipe.name = "slow-transport-belt"
recipe.enabled = true
recipe.result = "slow-transport-belt"


-- add belt
data:extend{entity, item, recipe}


-- entity underground
entity = table.deepcopy(data.raw["underground-belt"]["underground-belt"])
entity.name = "slow-underground-belt"
entity.icon = "__SlowBelt__/graphics/icons/slowug.png"
entity.minable.result = "slow-underground-belt"
entity.speed = entity.speed / 4

entity.belt_horizontal.filename = standard
entity.belt_horizontal.hr_version.filename = hr
entity.belt_vertical.filename = standard
entity.belt_vertical.hr_version.filename = hr
entity.ending_top.filename = standard
entity.ending_top.hr_version.filename = hr
entity.ending_bottom.filename = standard
entity.ending_bottom.hr_version.filename = hr
entity.ending_side.filename = standard
entity.ending_side.hr_version.filename = hr
entity.starting_top.filename = standard
entity.starting_top.hr_version.filename = hr
entity.starting_bottom.filename = standard
entity.starting_bottom.hr_version.filename = hr
entity.starting_side.filename = standard
entity.starting_side.hr_version.filename = hr

entity.structure.direction_in.sheet.filename = "__SlowBelt__/graphics/entity/underground-belt-structure.png"
entity.structure.direction_out.sheet.filename = "__SlowBelt__/graphics/entity/underground-belt-structure.png"

entity.order = "b[underground-belt]-a[slow-underground-belt]"


-- item underground
item = table.deepcopy(data.raw.item["underground-belt"])
item.name = "slow-underground-belt"
item.icon = "__SlowBelt__/graphics/icons/slowug.png"
item.order="b[underground-belt]-a[slow-underground-belt]"
item.icon_size=32
item.stack_size=50
item.place_result="slow-underground-belt"


-- recipe underground
recipe = table.deepcopy(data.raw.recipe["underground-belt"])
recipe.name = "slow-underground-belt"
recipe.enabled = true
recipe.result = "slow-underground-belt"


-- add underground
data:extend{entity, item, recipe}


-- entity splitter
entity = table.deepcopy(data.raw["splitter"]["splitter"])
entity.name = "slow-splitter"
entity.icon = "__SlowBelt__/graphics/icons/slowsplitter.png"
entity.minable.result = "slow-splitter"
entity.speed = entity.speed / 4

entity.belt_horizontal.filename = standard
entity.belt_horizontal.hr_version.filename = hr
entity.belt_vertical.filename = standard
entity.belt_vertical.hr_version.filename = hr
entity.ending_top.filename = standard
entity.ending_top.hr_version.filename = hr
entity.ending_bottom.filename = standard
entity.ending_bottom.hr_version.filename = hr
entity.ending_side.filename = standard
entity.ending_side.hr_version.filename = hr
entity.starting_top.filename = standard
entity.starting_top.hr_version.filename = hr
entity.starting_bottom.filename = standard
entity.starting_bottom.hr_version.filename = hr
entity.starting_side.filename = standard
entity.starting_side.hr_version.filename = hr

entity.structure.north.filename = "__SlowBelt__/graphics/entity/splitter-north.png"
entity.structure.east.filename = "__SlowBelt__/graphics/entity/splitter-east.png"
entity.structure.south.filename = "__SlowBelt__/graphics/entity/splitter-south.png"
entity.structure.west.filename = "__SlowBelt__/graphics/entity/splitter-west.png"

entity.order = "c[splitter]-a[slow-splitter]"


-- item splitter
item = table.deepcopy(data.raw.item["splitter"])
item.name = "slow-splitter"
item.icon = "__SlowBelt__/graphics/icons/slowsplitter.png"
item.order="c[splitter]-a[slow-splitter]"
item.icon_size=32
item.stack_size=50
item.place_result="slow-splitter"


-- recipe splitter
recipe = table.deepcopy(data.raw.recipe["splitter"])
recipe.name = "slow-splitter"
recipe.enabled = true
recipe.result = "slow-splitter"


-- add splitter
data:extend{entity, item, recipe}
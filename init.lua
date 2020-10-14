new_glass = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

-- Should soft glowing steel framed glass recipe be hidden
new_glass.hide_recipe_super_steel_framed = 1 == (
  tonumber(
    minetest.settings:get('new_glass.hide_recipe_super_steel_framed')
  ) or 0
)

dofile(modpath .. "/smoked.lua")
dofile(modpath .. "/obsidian_glow_a.lua")
dofile(modpath .. "/obsidian_glow_b.lua")
dofile(modpath .. "/rgb.lua")
dofile(modpath .. "/recipes.lua")

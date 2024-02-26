---------------------------------------------------------------
-- Smoked glass                                              --
---------------------------------------------------------------

-- A smoked glass recipe
minetest.register_craft({
  output = 'new_glass:smoked_glass 2',
  recipe = {
    {'default:glass', 'default:tin_ingot'},
    {'default:flint', 'default:flint'}
  }
})


-- Smoked glass, neutral
minetest.register_node("new_glass:smoked_glass", {
  description = "Smoked Glass",
  drawtype = "glasslike",
  tiles = {"smoked_glass_white.png" },
  paramtype = "light",
  sunlight_propagates = true,
  palette = "unifieddyes_palette_extended.png",
  groups = {oddly_breakable_by_hand = 3},
  alpha = 180,
  sounds = default.node_sound_glass_defaults(),
  is_ground_content = false,
})

-- Smoked glass, tinted
minetest.register_node("new_glass:smoked_glass_tinted", {
  description = "Smoked Glass (tinted)",
  drawtype = "glasslike",
  tiles = {"smoked_glass_white.png"},
  paramtype = "light",
  paramtype2 = "color",
  sunlight_propagates = true,
  palette = "unifieddyes_palette_extended.png",
  inventory_image = minetest.inventorycube("smoked_glass_white.png"),
  airbrush_replacement_node = "new_glass:smoked_glass_tinted",
  is_ground_content = false,
  alpha = 180,
  groups = {
    cracky = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1,
    not_in_creative_inventory = 1
  },
  sounds = default.node_sound_glass_defaults(),
  on_dig = unifieddyes.on_dig,
})

-- Register coloring for a tinted smoked glass
unifieddyes.register_color_craft({
  output = "new_glass:smoked_glass_tinted",
  type = "shapeless",
  palette = "extended",
  neutral_node = "new_glass:smoked_glass",
  recipe = {
    "NEUTRAL_NODE",
    "MAIN_DYE"
  }
})

---------------------------------------------------------------
-- Hard glowing framed obsidian glass                        --
---------------------------------------------------------------

-- Node definition for a hard glowing glass
minetest.register_node("new_glass:ultra_steel_framed_obsidian_glass", {
  description = "Ultra Steel-framed Obsidian Glass",
  drawtype = "glasslike_framed",
  tiles = {"framedglass_steel_frame.png", "framedglass_glass_face_clean.png"},
  paramtype = "light",
  sunlight_propagates = true,
  palette = "unifieddyes_palette_extended.png",
  airbrush_replacement_node = "new_glass:ultra_steel_framed_obsidian_glass_tinted",
  groups = {cracky = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
  sounds = default.node_sound_glass_defaults(),
  on_dig = unifieddyes.on_dig,
  light_source = 15,
})

-- Node definition for a hard glowing tinted glass
minetest.register_node("new_glass:ultra_steel_framed_obsidian_glass_tinted", {
  description = "Ultra Steel-framed Obsidian Glass (tinted)",
  drawtype = "glasslike_framed",
  tiles = {
    { name = "framedglass_steel_frame.png", color = "white" },
    "newglass_base.png",
  },
  paramtype = "light",
  paramtype2 = "color",
  sunlight_propagates = true,
  palette = "unifieddyes_palette_extended.png",
  inventory_image = minetest.inventorycube("framedglass_glass_face_inv_static.png"),
  airbrush_replacement_node = "new_glass:ultra_steel_framed_obsidian_glass_tinted",
  is_ground_content = true,
  use_texture_alpha = true,
  groups = {cracky = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
  sounds = default.node_sound_glass_defaults(),
  on_dig = unifieddyes.on_dig,
  light_source = 15,
})

-- Register coloring for a hard glowing tinted glass
unifieddyes.register_color_craft({
  output = "new_glass:ultra_steel_framed_obsidian_glass_tinted",
  type = "shapeless",
  palette = "extended",
  neutral_node = "new_glass:ultra_steel_framed_obsidian_glass",
  recipe = {
    "NEUTRAL_NODE",
    "MAIN_DYE"
  }
})

-- One hard-glowing glass from a steel framed one and two mese lamps
minetest.register_craft({
  output = 'new_glass:ultra_steel_framed_obsidian_glass',
  recipe = {
    {'framedglass:steel_framed_obsidian_glass', 'default:meselamp', 'default:meselamp'}
  }
})

-- One hard-glowing glass from a soft-glowing one and a mese lamp
minetest.register_craft({
  output = 'new_glass:ultra_steel_framed_obsidian_glass',
  recipe = {
    {'new_glass:super_steel_framed_obsidian_glass', 'default:meselamp'}
  }
})

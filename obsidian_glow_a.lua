---------------------------------------------------------------
-- Soft glowing framed obsidian glass                        --
---------------------------------------------------------------

-- Node definition for a soft glowing glass
minetest.register_node("new_glass:super_steel_framed_obsidian_glass", {
  description = "Super Steel-framed Obsidian Glass",
  drawtype = "glasslike_framed",
  tiles = {"framedglass_steel_frame.png", "framedglass_glass_face_clean.png"},
  paramtype = "light",
  sunlight_propagates = true,
  palette = "unifieddyes_palette_extended.png",
  airbrush_replacement_node = "new_glass:super_steel_framed_obsidian_glass_tinted",
  groups = {cracky = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
  sounds = default.node_sound_glass_defaults(),
  on_dig = unifieddyes.on_dig,
  light_source = 8,
})

-- Node definition for a soft glowing tinted glass
minetest.register_node("new_glass:super_steel_framed_obsidian_glass_tinted", {
  description = "Super Steel-framed Obsidian Glass (tinted)",
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
  airbrush_replacement_node = "new_glass:super_steel_framed_obsidian_glass_tinted",
  is_ground_content = true,
  use_texture_alpha = true,
  groups = {cracky = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
  sounds = default.node_sound_glass_defaults(),
  on_dig = unifieddyes.on_dig,
  light_source = 11,
})

-- Register coloring for a soft glowing tinted glass
unifieddyes.register_color_craft({
  output = "new_glass:super_steel_framed_obsidian_glass_tinted",
  type = "shapeless",
  palette = "extended",
  neutral_node = "new_glass:super_steel_framed_obsidian_glass",
  recipe = {
    "NEUTRAL_NODE",
    "MAIN_DYE"
  }
})

-- 4 soft-glowing glasses using a basic craft recipe and a mese block
if not new_glass.hide_recipe_super_steel_framed then
  minetest.register_craft({
    output = 'new_glass:super_steel_framed_obsidian_glass 4',
    recipe = {
      {'default:obsidian_glass', 'default:obsidian_glass', 'default:steel_ingot'},
      {'default:obsidian_glass', 'default:obsidian_glass', 'default:steel_ingot'},
      {'default:steel_ingot', 'default:steel_ingot', 'default:mese'},
    }
  })
end

-- One soft-glowing glass from a steel framed one and a meselamp
if not new_glass.hide_recipe_super_steel_framed then
  minetest.register_craft({
    output = 'new_glass:super_steel_framed_obsidian_glass',
    recipe = {
      {'framedglass:steel_framed_obsidian_glass', 'default:meselamp'}
    }
  })
end

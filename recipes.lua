-- Alternative meselamp recipes.
-- Those allow making mese lamps for new_glass and to save torches.
if minetest.get_modpath("moreblocks") then
  -- Make a mese lamp from clean_glass
  minetest.register_craft({
    type = "shapeless",
    output = "default:meselamp",
    recipe = {
      "moreblocks:clean_glass", "default:mese_crystal"
    }
  })
  -- Make a mese lamp from glow glas, return a torch
  minetest.register_craft({
    type = "shapeless",
    output = "default:meselamp",
    recipe = {
      "moreblocks:glow_glass", "default:mese_crystal"
    },
    replacements = {
      {"default:mese_crystal", "default:torch"}
    }
  })
  -- Make a mese lamp from super glow glass, return two torches
  minetest.register_craft({
    type = "shapeless",
    output = "default:meselamp",
    recipe = {
      "moreblocks:super_glow_glass", "default:mese_crystal"
    },
    replacements = {
      {"default:mese_crystal", "default:torch 2"}
    }
  })
end

if minetest.get_modpath("building_blocks") then
  -- Make a mese lamp from smoothglass
  minetest.register_craft({
    type = "shapeless",
    output = "default:meselamp",
    recipe = {
      "building_blocks:smoothglass", "default:mese_crystal"
    }
  })
end

-- Let's allow using both super and ultra glass in this recipe
if minetest.get_modpath("unifieddyes") and
   minetest.get_modpath("digilines") and
   minetest.get_modpath("mesecons_luacontroller") then
  minetest.register_craft({
    output = "new_glass:rgb_off",
    recipe = {
      {"new_glass:ultra_steel_framed_obsidian_glass"},
      {"mesecons_luacontroller:luacontroller0000"},
      {"digilines:wire_std_00000000"}
    }
  })
  minetest.register_craft({
    output = "new_glass:rgb_off",
    recipe = {
      {"new_glass:super_steel_framed_obsidian_glass"},
      {"mesecons_luacontroller:luacontroller0000"},
      {"digilines:wire_std_00000000"}
    }
  })
end

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

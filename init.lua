-- 4 soft-glowing glasses using a basic craft recipe and a mese block
minetest.register_craft({
	output = 'new_glass:super_steel_framed_obsidian_glass 4',
	recipe = {
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:steel_ingot'},
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:mese'},
	}
})

-- One soft-glowing glass from a steel framed one and a meselamp
minetest.register_craft({
	output = 'new_glass:super_steel_framed_obsidian_glass',
	recipe = {
		{'framedglass:steel_framed_obsidian_glass', 'default:meselamp'}
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

-- Node definition for a soft glowing glass
minetest.register_node("new_glass:super_steel_framed_obsidian_glass", {
	description = "Super Steel Framed Obsidian Glass",
	drawtype = "glasslike_framed",
	tiles = {"framedglass_steel_frame.png", "framedglass_glass_face_clean.png"},
	paramtype = "light",
	sunlight_propagates = true,
	palette = "unifieddyes_palette_extended.png",
	groups = {cracky=3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	on_dig = unifieddyes.on_dig,
        light_source = 11,
})

-- Node definition for a hard glowing glass
minetest.register_node("new_glass:ultra_steel_framed_obsidian_glass", {
	description = "Ultra Steel Framed Obsidian Glass",
	drawtype = "glasslike_framed",
	tiles = {"framedglass_steel_frame.png", "framedglass_glass_face_clean.png"},
	paramtype = "light",
	sunlight_propagates = true,
	palette = "unifieddyes_palette_extended.png",
	groups = {cracky=3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	on_dig = unifieddyes.on_dig,
        light_source = 15,
})

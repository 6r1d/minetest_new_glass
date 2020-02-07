minetest.register_craft({
	output = 'new_glass:super_steel_framed_obsidian_glass',
	recipe = {
		{'framedglass:steel_framed_obsidian_glass', 'default:meselamp'}
	}
})

minetest.register_craft({
	output = 'new_glass:ultra_steel_framed_obsidian_glass',
	recipe = {
		{'framedglass:steel_framed_obsidian_glass', 'default:meselamp', 'default:meselamp'}
	}
})

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

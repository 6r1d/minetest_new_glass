-- TODO add shard-sized scintillator crystals
-- and fragment-sized, wallmounted ones
-- for detecting radiation

local scintillator_timer = function(pos, elapsed)
    local scintillator_states = {
      "new_glass:scintillator",
      "new_glass:scintillator_blink",
      "new_glass:scintillator_glow"
    }
    minetest.swap_node( pos, {name=scintillator_states[math.random(#scintillator_states)]} )
    -- TODO return false, change timings, add math.random to each,
    -- so firing rate is less regular and server is not overloaded 
    --
    -- TODO add accidental 1s firings of "scintillator_blink"
    -- near weak radiation sources
    return true
end

local handle_construct = function(pos)
    local timer = minetest.get_node_timer(pos)
    -- TODO update timings to better values
    timer:start(5)
end

local register_scintillator = function(node_name, texture, light_value)
  minetest.register_node(node_name, {
    description = "Scintillator",
    drawtype = "glasslike",
    tiles = { texture },
    paramtype = "light",
    sunlight_propagates = true,
    palette = "unifieddyes_palette_extended.png",
    groups = {oddly_breakable_by_hand = 3},
    use_texture_alpha = true,
    sounds = default.node_sound_glass_defaults(),
    light_source = light_value,
    is_ground_content = true,
    on_construct = handle_construct,
    on_timer = scintillator_timer
  })
end

register_scintillator("new_glass:scintillator", "scintillator_off.png", 0)
register_scintillator("new_glass:scintillator_blink", "scintillator_blink.png", 2)
register_scintillator("new_glass:scintillator_glow", "scintillator_on.png", 14)

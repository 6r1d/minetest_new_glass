-- TODO
-- add shard-sized scintillator crystals and fragment-sized, wallmounted ones
-- for detecting radiation

-- Technic-related TODOs:
-- Decide if an override to dmg_abm(pos, node) is better.
-- Moreover, "calculate_base_damage" contains some kind of "raytacing",
-- maybe it should be used sometimes.

-- TODO
-- update cache when piston moves a block if mapblock position is cached

function table_empty(tab)
    if next(tab) == nil then
      return true
    end
    return false
end

-- Converts a node position to mapblock position.
-- A copy of postool.getPositionTablesForPos.
--
-- TODO: test, discuss and resolve this definition difference:
-- https://minetest.gitlab.io/minetest/map-terminology-and-coordinates/#nodes-mapblocks-mapchunks
-- blockpos = math.floor(nodepos / 16)
local get_mapblock = function(pos)
    local x = math.floor(pos.x + 0.5)
    local y = math.floor(pos.y + 0.5)
    local z = math.floor(pos.z + 0.5)
    return {
      x = math.floor(x / 16),
      y = math.floor(y / 16),
      z = math.floor(z / 16)
    }
end

-- Returns a list of {"group:radioactive"}
-- nodes in given mapblock coordinates.
local mapblock_radioactive_list = function(mbpos)
    -- Minimum: nodepos = blockpos * 16
    local min_pos = {
      x=mbpos.x * 16,
      y=mbpos.y * 16,
      z=mbpos.z * 16
    }
    -- Maximum: nodepos = blockpos * 16 + 15
    local max_pos = {
      x=mbpos.x * 16 + 15,
      y=mbpos.y * 16 + 15,
      z=mbpos.z * 16 + 15
    }
    -- Locate radioactive nodes
    return minetest.find_nodes_in_area(
      min_pos, max_pos,
      {"group:radioactive"}
    )
end

local scintillator_timer = function(pos, elapsed)
    local meta = minetest.get_meta(pos)
    local mapblock = {
      x=meta:get_int("blk_x"),
      y=meta:get_int("blk_y"),
      z=meta:get_int("blk_z")
    }

    -- TODO limit query to one block and distribute state to adjacent ones
    local radioactive_list = mapblock_radioactive_list(mapblock)

    -- local scintillator_states = {
    --   "new_glass:scintillator",
    --   "new_glass:scintillator_blink",
    --   "new_glass:scintillator_glow"
    -- }

    if table_empty(radioactive_list) then
      minetest.swap_node( pos, {name="new_glass:scintillator"} )
    else
      minetest.swap_node( pos, {name="new_glass:scintillator_glow"} )
    end

    -- minetest.swap_node( pos, {name=scintillator_states[math.random(#scintillator_states)]} )
    -- TODO return false, change timings, add math.random to each,
    -- so firing rate is less regular and server is not overloaded
    --
    -- TODO add accidental 1s firings of "scintillator_blink"
    -- near weak radiation sources
    return true
end

local update_block = function(pos)
    local meta = minetest.get_meta(pos)
    local mapblock = get_mapblock(pos)
    meta:set_int('blk_x', tonumber(mapblock.x))
    meta:set_int('blk_y', tonumber(mapblock.y))
    meta:set_int('blk_z', tonumber(mapblock.z))
end

local handle_construct = function(pos)
    local timer = minetest.get_node_timer(pos)
    -- TODO update timings to better values
    timer:start(1)
    -- Set mapblock
    update_block(pos)
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
    on_timer = scintillator_timer,
    -- TODO set as 100 or lower in fragment-sized version
    radiation_resistance = 300
  })
end

register_scintillator("new_glass:scintillator", "scintillator_off.png", 0)
register_scintillator("new_glass:scintillator_blink", "scintillator_blink.png", 2)
register_scintillator("new_glass:scintillator_glow", "scintillator_on.png", 14)

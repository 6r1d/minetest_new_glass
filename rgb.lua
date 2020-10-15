-- RGB glass block
--
-- Control options:
-- Reset a block:
--   digiline_send('rgb', { reset = math.random(0, 1) })
-- Switch glow:
--   digiline_send('rgb', { switch = math.random(0, 1) })
-- Change color:
--   digiline_send('rgb', { color = math.random(0, 255) })

local digiline_rules = {
  {x =  1, y =  0,z =  0,},
  {x =  2, y =  0,z =  0,},
  {x = -1, y =  0,z =  0,},
  {x = -2, y =  0,z =  0,},
  {x =  0, y =  1,z =  0,},
  {x =  0, y =  2,z =  0,},
  {x =  0, y = -1,z =  0,},
  {x =  0, y = -2,z =  0,},
  {x =  0, y =  0,z =  1,},
  {x =  0, y =  0,z =  2,},
  {x =  0, y =  0,z = -1,},
  {x =  0, y =  0,z = -2,},
}

local digiline_action = function(pos, node, channel, msg)
  local setchannel = minetest.get_meta(pos):get_string("channel")
  -- Ignore other digiline channels
  if channel ~= setchannel or type(msg) ~= "table" then return end
  -- Set color
  if (msg.color ~= nil) and (type(msg.color) == "string" or type(msg.color) == "number") then
    node.param2 = msg.color
    minetest.swap_node(pos, node)
  end
  -- Enable / disable glow
  if (msg.switch ~= nil) and (type(msg.switch) == "string" or type(msg.switch) == "number") then
    if msg.switch == 'on' or msg.switch >= 1 then
      minetest.swap_node(pos, {name = "new_glass:rgb_on", param2 = node.param2 })
    else
      minetest.swap_node(pos, {name = "new_glass:rgb_off", param2 = node.param2 })
    end
  end
  -- Reset handler (int)
  if (msg.reset ~= nil) and (type(msg.reset) == "number") then
    if msg.reset >= 1 then
      -- I am hardcoding a param2, because for some reason it has a default value
      minetest.swap_node(pos, {name = "new_glass:rgb_off", param2 = 240 })
    end
  end
end

local handle_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("formspec","field[channel;Channel;${channel}")
end

local handle_receive_fields = function(pos, formname, fields, sender)
    local meta = minetest.get_meta(pos)
    if fields.channel then meta:set_string("channel", fields.channel) end
end

-- Override for unifieddyes implementation of on_dig,
-- because I was not able to use it.
local on_dig_rgb = function(pos, node, digger)
    -- No player - no drop, may be incompatible with digtrons
    if not digger then return end
    -- Retrieve metadata
    local inv = digger:get_inventory()
    -- luacheck: globals ItemStack
    local item = ItemStack("new_glass:rgb_off")
    -- Give player an item or drop it
    if inv:room_for_item("main", item) then
      inv:add_item("main", item)
    else
      minetest.item_drop(item, digger, pos)
    end
    minetest.remove_node(pos)
end

local register_rgb_glass = function(node_name, light_value)
  minetest.register_node(node_name, {
    description = "RGB Glass",
    drawtype = "glasslike_framed",
    tiles = {
      { name = "steel_frame.png", color = "white" },
      "newglass_base.png",
    },
    paramtype = "light",
    paramtype2 = "color",
    sunlight_propagates = true,
    palette = "unifieddyes_palette_extended.png",
    inventory_image = minetest.inventorycube("framedglass_glass_face_inv_static.png"),
    airbrush_replacement_node = "new_glass:ultra_steel_framed_obsidian_glass_tinted",
    use_texture_alpha = true,
    groups = {
      cracky = 3,
      oddly_breakable_by_hand = 3,
      ud_param2_colorable = 1
    },
    sounds = default.node_sound_glass_defaults(),
    on_dig = on_dig_rgb,
    light_source = light_value,
    -- Set formspec for digiline channel selection
    on_construct = handle_construct,
    -- Update digiline channel
    on_receive_fields = handle_receive_fields,
    -- Digiline settings
    digiline = {
    receptor = {},
      wire = {
        rules = digiline_rules,
      },
      effector = {
        action = digiline_action
      },
    },
  })
  -- Register dyes
  unifieddyes.register_color_craft({
    output = node_name,
    type = "shapeless",
    palette = "extended",
    neutral_node = node_name,
    recipe = { "NEUTRAL_NODE", "MAIN_DYE" }
  })
end

if minetest.get_modpath("unifieddyes") and minetest.get_modpath("digilines") then
  register_rgb_glass("new_glass:rgb_off", 0)
  register_rgb_glass("new_glass:rgb_on",  14)
end

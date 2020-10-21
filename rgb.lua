-- RGB glass block

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

--local translatedColour(s)
-- SX's code:
-- s = "#a1b2c3" -- dec 161, 178, 195
-- r = tonumber("0x" .. s:sub(2,3))
-- g = tonumber("0x" .. s:sub(4,5))
-- b = tonumber("0x" .. s:sub(6,7))
--
-- Issue: we have colors marked by integers from 0 to 255, i.e.
-- in this example we get 161 + 178 + 195, which is 534,
-- outside of 0-255 boundaries.
--
-- Notes:
--   unifieddyes mod seem to have a unique approach to coloring, closest to HSV
--   first five colors seem to be completely useless, but might be bright shades of white
--   unifieddyes.HUES_EXTENDED contains 24 hues for 256 color palette
--   unifieddyes.shade_crafts contains 10 shades a hue can take
--   last ten colors seem to be the color values from brightest to darkest
--
-- Proposed solution:
--   use SX's RGB code to obtain R,G,B value.
--   find the hue, closest to the given R, G, B values, it will give us a range inside 256-color palette
--   apply saturation and value
--end

local digiline_action = function(pos, node, channel, mixed_msg)
  local setchannel = minetest.get_meta(pos):get_string('channel')
  -- Ignore other digiline channels
  if channel ~= setchannel then return end
  local msg_type = type(mixed_msg)
  local msg = {}
  if 'string' == msg_type then
    local s = mixed_msg:lower()
    if 'on' == s then
      msg.switch = 1
    elseif 'off' == s then
      msg.switch = 0
    elseif 'reset' == s then
      msg.reset = 1
    --elseif '#' == s:sub(1, 1) then
      -- TODO:
      --msg.color = translatedColour(s)
    end
  elseif 'table' == msg_type then
    msg = mixed_msg
  else
    return
  end
  local changed = false
  -- Set color
  if (msg.color ~= nil) and (type(msg.color) == 'string' or type(msg.color) == 'number') then
    node.param2 = msg.color
    changed = true
  end
  -- Enable / disable glow
  if nil ~= msg.switch then
    changed = true
    if 0 == msg.switch then
      node.name = 'new_glass:rgb_off'
    else
      node.name = 'new_glass:rgb_on'
    end
  end
  -- Reset handler (int)
  if msg.reset ~= nil and type(msg.reset) == 'number' then
    if msg.reset >= 1 then
      changed = true
      -- I am hardcoding a param2, because for some reason it has a default value
      node = { name = 'new_glass:rgb_off', param2 = 240 }
    end
  end

  if changed then
    minetest.swap_node(pos, node)
  end
end

local handle_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string('formspec', 'field[channel;Channel;${channel}')
end

local handle_receive_fields = function(pos, formname, fields, sender)
    local name = sender:get_player_name()
    local meta = minetest.get_meta(pos)
    local owner = meta:get_string('owner')
    if minetest.is_protected(pos, name) then
      return
    else
      if fields.channel then meta:set_string('channel', fields.channel) end
    end
end

local register_rgb_glass = function(node_name, light_value)
  minetest.register_node(node_name, {
    description = 'RGB Glass',
    drawtype = 'glasslike_framed',
    tiles = {
      { name = 'steel_frame.png', color = 'white' },
      'newglass_base.png'
    },
    paramtype = 'light',
    paramtype2 = 'color',
    sunlight_propagates = true,
    palette = 'unifieddyes_palette_extended.png',
    inventory_image = minetest.inventorycube('framedglass_glass_face_inv_static.png'),
    airbrush_replacement_node = 'new_glass:ultra_steel_framed_obsidian_glass_tinted',
    use_texture_alpha = true,
    groups = {
      cracky = 3,
      oddly_breakable_by_hand = 3,
      ud_param2_colorable = 1
    },
    sounds = default.node_sound_glass_defaults(),
    drop = 'new_glass:rgb_off',
    light_source = light_value,
    -- Set formspec for digiline channel selection
    on_construct = handle_construct,
    -- Update digiline channel
    on_receive_fields = handle_receive_fields,
    -- Digiline settings
    _digistuff_channelcopier_fieldname = 'channel',
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
    type = 'shapeless',
    palette = 'extended',
    neutral_node = node_name,
    recipe = { 'NEUTRAL_NODE', 'MAIN_DYE' }
  })
end

if minetest.get_modpath('unifieddyes') and minetest.get_modpath('digilines') then
  register_rgb_glass('new_glass:rgb_off', 0)
  register_rgb_glass('new_glass:rgb_on',  14)
end

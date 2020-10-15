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
  -- Enable / disable glow
  if (msg.switch ~= nil) and (type(msg.switch) == "string" or type(msg.switch) == "number") then
    if msg.switch == 'on' or msg.switch == 1 then
      minetest.swap_node(pos, {name = "new_glass:rgb_on" })
    else
      minetest.swap_node(pos, {name = "new_glass:rgb_off" })
    end
  end
  -- Set color
  if (msg.color ~= nil) and (type(msg.color) == "string" or type(msg.color) == "number") then
    node.param2 = msg.color
    minetest.swap_node(pos, node)
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
      cracky = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1
    },
    sounds = default.node_sound_glass_defaults(),
    on_dig = unifieddyes.on_dig,
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
  -- Forcibly register RGB craftitem
  --minetest.register_craftitem("new_glass:rgb_off", {
  --  description = "RGB glass",
  --})
end

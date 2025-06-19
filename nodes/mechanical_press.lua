local set_info = PlexTechApi.compat.set_info

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

core.register_node("plextech:mechanical_press", {
	description = "Mechanical Press",
	legacy_facedir_simple = true,
	is_ground_content = false,
	tiles = {
		"machine_side.png",
		"machine_side.png",
		"machine_side.png",
		"machine_side.png",
		"machine_side.png",
		"press_off.png",
	},
	paramtype2 = "facedir",
	on_construct = function(pos, placer)
		local meta = core.get_meta(pos)
		meta:set_string(
			"formspec",
			"size[8,9]"
				.. "list[context;src;2.75,1.5;1,1;]"
				.. "image[0,0;0.7,0.4;ax.png]"
				.. "image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"
				.. "list[context;dst;4.75,1.5;2,2;]"
				.. "list[context;main;0,0;8,4]"
				.. "list[current_player;main;0,5;8,4]"
				.. "label[1,0;Mechanical Press]"
				.. "field[0.5,1;5,1;active;Active;0]"
				.. "field_close_on_enter[active;false]"
		)
		local inv = meta:get_inventory()
		inv:set_size("src", 1)
		inv:set_size("dst", 1)
		set_info(pos, "Not active")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if WhatIsThisApi ~= nil then
			if not fields.active or fields.active == "" then
				return
			end
			fields.active = tonumber(fields.active) or 0
			if fields.active == 1 then
				swap_node(pos, "plextech:mechanical_press_active")
				set_info(pos, "Active")
			end
		end
	end,
})

core.register_node("plextech:mechanical_press_active", {
	description = "Mechanical Press",
	legacy_facedir_simple = true,
	is_ground_content = false,
	tiles = {
		"machine_side.png",
		"machine_side.png",
		"machine_side.png",
		"machine_side.png",
		"machine_side.png",
		{
			name = "press_on.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 5,
			},
		},
	},
	paramtype2 = "facedir",
	groups = { not_in_creative_inventory = 1 },
	on_receive_fields = function(pos, formname, fields, sender)
		if WhatIsThisApi ~= nil then
			if not fields.active or fields.active == "" then
				return
			end
			fields.active = tonumber(fields.active) or 1
			if fields.active == 0 then
				swap_node(pos, "plextech:mechanical_press")
				set_info(pos, "Not active")
			end
		end
	end,
})

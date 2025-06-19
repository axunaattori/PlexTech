local set_info = PlexTechApi.compat.set_info

dofile(minetest.get_modpath("plextech") .. "/nodes/mechanical_press.lua")

core.register_node("plextech:void_miner", {
	description = "Void Miner",
	tiles = { "machine_side.png" },
})

core.register_node("plextech:infinite_energy_source", {
	description = "Infinite Energy Source",
	tiles = { "iesmachine.png" },
	on_construct = function(pos, placer)
		local meta = core.get_meta(pos)
		meta:set_string(
			"formspec",
			"size[8,9]"
				.. "list[context;main;0,0;8,4]"
				.. "list[current_player;main;0,5;8,4]"
				.. "image[0,0;0.7,0.4;ax.png]"
				.. "label[1,0;Infinite Energy Source]"
				.. "field[0.5,1;5,1;energy;Energy;0]"
				.. "field_close_on_enter[energy;false]"
		)

		set_info(pos, "Energy: 0")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if WhatIsThisApi ~= nil then
			if not fields.energy or fields.energy == "" then
				return
			end
			set_info(pos, "Energy: " .. tostring(tonumber(fields.energy)))
		end
	end,
})

core.register_node("plextech:basic_machine_hull", {
	description = "Basic Machine Hull",
	tiles = { "machine_side.png" },
})

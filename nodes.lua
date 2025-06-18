local function rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:get_pos()
		if placer_pos then
			local diff = vector.subtract(p1, placer_pos)
			param2 = minetest.dir_to_facedir(diff)
			-- The player places a node on the side face of the node he is standing on
			if p0.y == p1.y and math.abs(diff.x) <= 0.5 and math.abs(diff.z) <= 0.5 and diff.y < 0 then
				-- reverse node direction
				param2 = (param2 + 2) % 4
			end
		end

		local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
		local fpos = finepos.y % 1

		if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5) or (fpos < -0.5 and fpos > -0.999999999) then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

function randomNodes()
	core.register_node("plextech:basic_machine_hull", {
		description = "Basic Machine Hull",
		tiles = { "machine_side.png" },
	})
end

function registerMachines()
	core.register_node("plextech:mechanical_press", {
		description = "Mechanical Press",
		tiles = {
			"machine_side.png",
			"machine_side.png",
			"machine_side.png",
			"machine_side.png",
			"machine_side.png",
			"press_off.png",
		},
		paramtype2 = "facedir",
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
		on_construct = function(pos, placer)
			local meta = core.get_meta(pos)
			local esc = minetest.formspec_escape
			meta:set_string(
				"formspec",
				"size[8,9]"
					.. "list[context;main;0,0;8,4]"
					.. "list[current_player;main;0,5;8,4]"
					.. "image[0,0;0.7,0.4;ax.png]"
					.. "label[1,0;Mechanical Press]"
			)
		end,
	})

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
			if WhatIsThisApi ~= nil then
				WhatIsThisApi.set_info(pos, "Energy: 0")
			end
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if WhatIsThisApi ~= nil then
				WhatIsThisApi.set_info(pos, "Energy: " .. tostring(tonumber(fields.energy)))
			end
		end,
	})
end

return nodeslua

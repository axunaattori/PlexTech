core.register_on_mods_loaded(function()
	core.clear_craft({ output = "default:bronze_ingot" })

	core.register_craft({
		type = "cooking",
		output = "default:bronze_ingot",
		recipe = "group:bronze_dust",
		cooktime = 10,
	})
end)

core.register_craft({
	type = "shapeless",
	output = "plextech:bronze_dust 8", -- minetest does it 9 so nerf it :P
	recipe = {
		"group:tin_dust",
		"group:copper_dust",
		"group:copper_dust",
		"group:copper_dust",
		"group:copper_dust",
		"group:copper_dust",
		"group:copper_dust",
		"group:copper_dust",
		"group:copper_dust",
	},
})

return recipeslua

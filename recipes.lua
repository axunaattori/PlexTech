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

-- add missing "default" dust -> ingot recipes since the material "API" is designed for plextech only at this moment

core.register_craft({
	type = "cooking",
	output = "default:tin_ingot",
	recipe = "group:tin_dust",
	cooktime = 10,
})

core.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "group:copper_dust",
	cooktime = 10,
})

core.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "group:steel_dust",
	cooktime = 10,
})

core.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "group:gold_dust",
	cooktime = 10,
})

return recipeslua

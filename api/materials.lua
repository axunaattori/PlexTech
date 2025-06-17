--technically just an API for material creation, misleading name might rename it (like materialapi.lua) or do something to it
--it's possible that ill add more recipes to the functions so please use 1 for currently existing material stuff

local minetestElementsPT = --write like "Copper Alloy" in list itll try to normalizee it into copper_alloy for the plextech:XXX_name_whatever
	{
		"Bronze",
		"Copper",
		"Steel",
		"Tin",
		"Gold",
	}

minetestElementColors = -- add minetest colors
	{
		"#e56209", -- bronze
		"#ec923a", -- copper
		"#eeece8", -- steel
		"#b4b3b1", -- tin
		"#ffd100", -- gold
	}

PTMaterial = -- mod materials
	{
		"Pig iron",
		"Iron",
		"Wrought iron",
	}

PTMaterialColors = {
	"#b49696", -- pig iron
	"#c8c8c8", -- iron
	"#8c6e6e", -- wrought iron
}

local function normalize(string) --returns "hello_world" from "Hello World" for example.
	return (string:lower():gsub("%s", "_"))
end

core.register_on_mods_loaded(function()
	for _, element in pairs(minetestElementsPT) do
		local normalized = normalize(element .. "_ingot")
		local default = "default:" .. normalized
		if core.registered_craftitems[default] then
			local def = core.registered_craftitems[default]
			local groups = table.copy(def.groups)
			groups[normalized] = 1
			core.override_item(default, { groups = groups })
		end
	end
end)

function registerDust(name, recipe, color)
	if not color then
		color = "#FFFFFF"
	end
	core.register_craftitem("plextech:" .. normalize(name) .. "_dust", {
		description = name .. " dust",
		groups = {
			[normalize(name) .. "_dust"] = 1,
		},
		inventory_image = "dust.png^[multiply:" .. color,
	})

	if recipe ~= 0 then
		core.register_craft({ --todo add tool to crush stuff
			type = "shapeless",
			output = "plextech:" .. normalize(name) .. "_dust",
			recipe = {
				"group:" .. normalize(name) .. "_ingot",
			},
		})
	end
end

function registerPlate(name, recipe, color) --ill find a bettery way trust -06/12/2025
	if not color then
		color = "#FFFFFF"
	end
	core.register_craftitem("plextech:" .. normalize(name) .. "_plate", {
		description = name .. " plate",
		groups = {
			[normalize(name) .. "_plate"] = 1,
		},
		inventory_image = "plate.png^[multiply:" .. color,
	})

	if recipe ~= 0 then
		core.register_craft({
			type = "shaped",
			output = "plextech:" .. normalize(name) .. "_plate",
			recipe = {
				{ "plextech:hammer" },
				{ "group:" .. normalize(name) .. "_ingot" },
				{ "group:" .. normalize(name) .. "_ingot" },
			},
			replacements = { { "plextech:hammer", "plextech:hammer" } },
		})
	end
end

function registerIngot(name, recipe, color) --smelting recipe blah blah dust -> ingot, ill do it for the default ones too someday ;)
	if not color then
		color = "#FFFFFF"
	end
	core.register_craftitem("plextech:" .. normalize(name) .. "_ingot", {
		description = name .. " ingot",
		groups = {
			[normalize(name) .. "_ingot"] = 1,
		},
		inventory_image = "ingot.png^[multiply:" .. color,
	})

	if recipe ~= 0 then
		core.register_craft({
			type = "cooking",
			output = "plextech:" .. normalize(name) .. "_ingot",
			recipe = "group:" .. normalize(name) .. "_dust",
			cooktime = 10,
		})
	end
end

core.register_craftitem(
	"plextech:hammer",
	{ --move to own file whenever feel like it, dont need to do it now :p, its not doing anything annoying so why change it?
		description = "Hammer",
		stack_max = 1,
		inventory_image = "hammer.png",
	}
)

core.register_craft({
	type = "shaped",
	output = "plextech:hammer",
	recipe = {
		{ "group:bronze_ingot", "group:bronze_ingot", "" },
		{ "group:bronze_ingot", "group:bronze_ingot", "default:stick" },
		{ "group:bronze_ingot", "group:bronze_ingot", "" },
	},
})

return minetestElementsPT

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

core.register_craft({
	type = "shaped",
	output = "plextech:hammer",
	recipe = {
		{ "group:bronze_ingot", "group:bronze_ingot", "" },
		{ "group:bronze_ingot", "group:bronze_ingot", "default:stick" },
		{ "group:bronze_ingot", "group:bronze_ingot", "" },
	},
})

local minetest_elements = {
	{ "Bronze", "#e56209" },
	{ "Copper", "#ec923a" },
	{ "Steel", "#eeece8" },
	{ "Tin", "#b4b3b1" },
	{ "Gold", "#ffd100" },
	{ "Diamond", "#00C808", 0 },
}

local plextech_materials = {
	{ "Pig iron", "#b49696" },
	{ "Iron", "#c8c8c8" },
	{ "Wrought iron", "#8c6e6e" },
}

local registerDust = PlexTechApi.materials.registerDust
local registerPlate = PlexTechApi.materials.registerPlate
local registerIngot = PlexTechApi.materials.registerIngot

local function register_elements(elements, with_ingot)
	for _, element in ipairs(elements) do
		local name, color, recipe = element[1], element[2], element[3] or 1
		registerDust(name, recipe, color)
		registerPlate(name, recipe, color)
		if with_ingot then
			registerIngot(name, recipe, color)
		end
	end
end

register_elements(minetest_elements, false) --ingots already exist
register_elements(plextech_materials, true)

local normalize = PlexTechApi.materials.normalize

minetest.register_on_mods_loaded(function()
	for _, element in pairs(minetest_elements) do
		element = element[1]
		if element[3] ~= 0 then
			local normalized = normalize(element .. "_ingot")
			local default = "default:" .. normalized
			if core.registered_craftitems[default] then
				local def = core.registered_craftitems[default]
				local groups = table.copy(def.groups)
				groups[normalized] = 1
				core.override_item(default, { groups = groups })
			end
		end
	end

	minetest.clear_craft({ output = "default:bronze_ingot" })
	minetest.register_craft({
		type = "cooking",
		output = "default:bronze_ingot",
		recipe = "group:bronze_dust",
		cooktime = 10,
	})
end)

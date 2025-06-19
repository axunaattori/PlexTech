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

local minetestElementsPT = {
	"Bronze",
	"Copper",
	"Steel",
	"Tin",
	"Gold",
}

local minetestElementColors = {
	bronze = "#e56209",
	copper = "#ec923a",
	steel = "#eeece8",
	tin = "#b4b3b1",
	gold = "#ffd100",
}

local PTMaterial = {
	"Pig iron",
	"Iron",
	"Wrought iron",
}

local PTMaterialColors = {
	pig_iron = "#b49696",
	iron = "#c8c8c8",
	wrought_iron = "#8c6e6e",
}

local registerDust = PlexTechApi.materials.registerDust
local registerPlate = PlexTechApi.materials.registerPlate
local registerIngot = PlexTechApi.materials.registerIngot

for _, element in pairs(minetestElementsPT) do
	registerDust(element, 1, minetestElementColors[element:lower()])
	registerPlate(element, 1, minetestElementColors[element:lower()])
end

registerPlate("Diamond", 0, "#00C8C8")
registerDust("Diamond", 0, "#00C8C8")

for _, element in pairs(PTMaterial) do
	registerDust(element, 1, PTMaterialColors[element:lower()])
	registerPlate(element, 1, PTMaterialColors[element:lower()])
	registerIngot(element, 1, PTMaterialColors[element:lower()])
end

local normalize = PlexTechApi.materials.normalize
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

	core.clear_craft({ output = "default:bronze_ingot" })
	core.register_craft({
		type = "cooking",
		output = "default:bronze_ingot",
		recipe = "group:bronze_dust",
		cooktime = 10,
	})
end)

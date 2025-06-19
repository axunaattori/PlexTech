local minetest = minetest or core -- Ensure compatibility with both 'minetest' and 'core'

local function normalize(str)
	return (str:lower():gsub("%s", "_"))
end

local function register_item(suffix, name, color)
	color = color or "#FFFFFF"
	local norm = normalize(name)
	local desc = name .. " " .. suffix
	local img = suffix .. ".png^[multiply:" .. color
	local group = { [norm .. "_" .. suffix] = 1 }
	minetest.register_craftitem("plextech:" .. norm .. "_" .. suffix, {
		description = desc,
		groups = group,
		inventory_image = img,
	})
end

local function registerDust(name, recipe, color)
	register_item("dust", name, color)
	if recipe ~= 0 then
		minetest.register_craft({
			type = "shapeless",
			output = "plextech:" .. normalize(name) .. "_dust",
			recipe = { "group:" .. normalize(name) .. "_ingot" },
		})
	end
end

local function registerPlate(name, recipe, color)
	register_item("plate", name, color)
	if recipe ~= 0 then
		minetest.register_craft({
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

local function registerIngot(name, recipe, color)
	register_item("ingot", name, color)
	if recipe ~= 0 then
		minetest.register_craft({
			type = "cooking",
			output = "plextech:" .. normalize(name) .. "_ingot",
			recipe = "group:" .. normalize(name) .. "_dust",
			cooktime = 10,
		})
	end
end

return {
	normalize = normalize,
	registerDust = registerDust,
	registerPlate = registerPlate,
	registerIngot = registerIngot,
}

local minetestElementsPT = dofile(minetest.get_modpath("plextech") .. "/items.lua")
local nodeslua = dofile(minetest.get_modpath("plextech") .. "/nodes.lua")
local recipeslua = dofile(minetest.get_modpath("plextech") .. "/recipes.lua")

print("Hello from PlexTech")

for i = 1, #minetestElementsPT do
	registerDust(minetestElementsPT[i], 1, minetestElementColors[i])
	registerPlate(minetestElementsPT[i], 1, minetestElementColors[i])
end

registerPlate("Diamond", 0, "#00C8C8")
registerDust("Diamond", 0, "#00C8C8")

for i = 1, #PTMaterial do
	registerIngot(PTMaterial[i], 1, PTMaterialColors[i])
	registerPlate(PTMaterial[i], 1, PTMaterialColors[i])
	registerDust(PTMaterial[i], 1, PTMaterialColors[i])
end

registerMachines()
randomNodes()

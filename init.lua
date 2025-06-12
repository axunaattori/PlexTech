local minetestElementsPT = dofile(minetest.get_modpath("plextech") .. "/items.lua")

print("Hello from PlexTech")

for i = 1, #minetestElementsPT do
	registerDust(minetestElementsPT[i], 1, minetestElementColors[i])
	registerPlate(minetestElementsPT[i], 1, minetestElementColors[i])
	print("PT: " .. minetestElementsPT[i] .. " registered")
end

for i = 1, #PTMaterial do
	registerIngot(PTMaterial[i], 1, PTMaterialColors[i])
	registerPlate(PTMaterial[i], 1, PTMaterialColors[i])
	registerDust(PTMaterial[i], 1, PTMaterialColors[i])
	print("PT: " .. PTMaterial[i] .. " registered")
end

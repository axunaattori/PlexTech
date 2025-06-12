local minetestElementsPT = dofile(minetest.get_modpath("plextech").."/items.lua")
print(minetestElementsPT)

print("Hello from PlexTech")

for i=1, #minetestElementsPT do
    registerDust(minetestElementsPT[i], 1)
    registerPlate(minetestElementsPT[i], 1)
    print("PT: " .. minetestElementsPT[i] .. " registered")
end


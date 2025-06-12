local minetestElementsPT = --write like "Copper Alloy" in list itll try to normalizee it into copper_alloy for the plextech:XXX_name_whatever
{
"Bronze",
"Copper",
"Steel",
"Tin",
"Gold"
}

local function normalize(string) --returns "hello_world" from "Hello World" for example.
    return (string:lower():gsub("%s", "_"))
end

core.register_on_mods_loaded(function()
    for _, element in pairs(minetestElementsPT) do
        local normalized = normalize(element .. "_ingot")
        local default = "default:" .. normalized    
        if core.registered_craftitems[default] then
            print("Got past " .. normalized .. ", " .. default)
            local def = core.registered_craftitems[default]
            local groups = table.copy(def.groups)
            groups[normalized] = 1
            core.override_item(default, { groups=groups })
        end
    end
end)


function registerDust(name, recipe)
    core.register_craftitem("plextech:" .. normalize(name) .. "_dust", {
    description = name .. " dust"
    })
    
    if recipe ~= 0 then
        core.register_craft({ --todo add tool to crush stuff
            type = "shapeless",
            output = "plextech:" .. normalize(name) .. "_dust",
            recipe = {
                    "group:" .. normalize(name) .. "_ingot"
                }
        })
    end
end

function registerPlate(name, recipe) --ill find a bettery way trust -06/12/2025
    core.register_craftitem("plextech:" .. normalize(name) .. "_plate", {
    description = name .. " plate"
    })

    if recipe ~= 0 then
        core.register_craft({ --todo add hammer
            type = "shaped",
            output = "plextech:" .. normalize(name) .. "_plate",
            recipe = {
                {""},
                {"group:" .. normalize(name) .. "_ingot"},
                {"group:" .. normalize(name) .. "_ingot"}
            }
        })
    end
end

return minetestElementsPT

local materials = dofile(minetest.get_modpath("plextech") .. "/api/materials.lua")

PlexTechApi = {
	materials = materials,
	compat = {
		set_info = function(pos, text)
			if WhatIsThisApi == nil then
				return
			end

			WhatIsThisApi.set_info(pos, text)
		end,
	},
}

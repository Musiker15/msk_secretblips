Config = {}
----------------------------------------------------------------
Config.Locale = 'de'
Config.VersionChecker = true
Config.Debug = true
----------------------------------------------------------------
Config.Framework = 'ESX' -- Set to 'ESX' or 'QBCore'
----------------------------------------------------------------
Config.RemoveItem = true -- Set this to 'false' if you don't want to remove blips after you removed the item from your inventory.

Config.EnableBlipTime = true -- Set to 'true' if you want to remove blips after time.
Config.BlipTime = 10 -- in seconds // After this time the blips will be removed.
----------------------------------------------------------------
Config.BlipItems = {
	['drug_map'] = { -- Itemname
		{x = -2018.96, y = 2838.15, z = 32.81, display = "Blip1", blip = 51, color = 5, scale = 0.8},
		{x = -2018.96, y = 2858.15, z = 32.81, display = "Blip1", blip = 51, color = 5, scale = 0.8},
	},
	['drug_map2'] = { -- Itemname
		{x = -2076.72, y = 2870.98, z = 32.81, display = "Blip2", blip = 51, color = 2, scale = 0.8},
		{x = -2076.72, y = 2893.98, z = 32.81, display = "Blip2", blip = 51, color = 2, scale = 0.8},
	},
	['drug_map3'] = { -- Itemname
		{x = -2103.81, y = 2886.16, z = 32.81, display = "Blip3", blip = 51, color = 3, scale = 0.8},
	},
}
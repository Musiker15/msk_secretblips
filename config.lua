Config = {}
Config.Locale = 'de'

Config.Framework = 'ESX' -- Set to 'ESX' or 'QBCore' || If 'nil', the Script won't work.

-- Only works for ESX Framework, not for QBCore yet.
Config.RemoveItem = true -- Set this to 'false' if you don't want to remove blips after you removed the item form you inventory.

Config.EnableBlipTime = false -- Set to 'true' if you want to remove blips after time.
Config.BlipTime = 60 -- in seconds // After this time the blips will be removed.

Config.DrugItem = "drug_map" -- Set your Item here then insert into your database.
Config.SecretBlips = { -- Add your Blips here
	{x = -623.44, y = -823.08, z = 25.25, display = "Blipname", blip = 51, color = 5, scale = 0.8},
}
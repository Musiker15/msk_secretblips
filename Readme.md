# SecretBlips
FiveM Script - Make Blips visible with an Item

**FiveM Forum:** https://forum.cfx.re/t/release-esx-secretblips-make-blips-visible-with-an-item/4795682

## Description
* You can set the Item you want to use.
* You can set the Blips that you want to show after using the item.

## Config
```
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
```

## Requirements
* ESX 1.2 (https://github.com/esx-framework/es_extended/releases/tag/v1-final)
* QBCore (https://forum.cfx.re/t/qbcore-framework/4116674)

## License
**GNU General Public License v3.0**

You can use and edit this Script but please do not reupload this without tagging me

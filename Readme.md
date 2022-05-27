# SecretBlips
FiveM Script - Make Blips visible with an Item

**FiveM Forum:** https://forum.cfx.re/t/release-esx-secretblips-make-blips-visible-with-an-item/4795682

**Discord Support:** https://discord.gg/5hHSBRHvJE

## Description
* You can set the Item you want to use.
* You can set the Blips that you want to show after using the item.

## Config
```
Config = {}
----------------------------------------------------------------
Config.Locale = 'de' -- 'de', 'en'
Config.VersionChecker = true
Config.Debug = true
----------------------------------------------------------------
Config.Framework = 'ESX' -- Set to 'ESX' or 'QBCore' || If 'nil', the Script won't work.
----------------------------------------------------------------
-- Only works for ESX Framework, not for QBCore yet.
Config.RemoveItem = true -- Set this to 'false' if you don't want to remove blips after you removed the item form you inventory.
----------------------------------------------------------------
Config.EnableBlipTime = false -- Set to 'true' if you want to remove blips after time.
Config.BlipTime = 60 -- in seconds // After this time the blips will be removed.
----------------------------------------------------------------
Config.DrugItem = "drug_map" -- Set your Item here then insert into your database.
Config.SecretBlips = { -- Add your Blips here
	{x = -623.44, y = -823.08, z = 25.25, display = "Blipname", blip = 51, color = 5, scale = 0.8},
}
```

## Requirements
* ESX 1.2 (https://github.com/esx-framework/es_extended/releases/tag/v1-final)
* QBCore (https://forum.cfx.re/t/qbcore-framework/4116674)

## My other Scripts
* [[ESX] Armor Script - Usable Armor Vests](https://forum.cfx.re/t/release-esx-armor-script-usable-armor-vests-status-will-be-saved-in-database-and-restore-after-relog/4812243)
* [[ESX] Weapon Ammunition with Clips, Components & Tints](https://forum.cfx.re/t/release-esx-weapon-ammunition-with-clips-components-tints/4793783)
* [[ESX/QBCore] Simcard - Change your phonenumber](https://forum.cfx.re/t/release-esx-qbcore-usable-simcard/4847008)
* [[ESX] Shopsystem - NativeUI & Database Feature](https://forum.cfx.re/t/release-esx-msk-shopsystem-nativeui-database-feature/4853593)

## License
**GNU General Public License v3.0**

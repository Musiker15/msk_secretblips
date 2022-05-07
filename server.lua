if Config.Framework:match('ESX') then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	local IsEnabled = false

	ESX.RegisterUsableItem(Config.DrugItem, function(source)
		if not IsEnabled then
			IsEnabled  = true
			TriggerClientEvent('SecretBlips:ShowBlip', source)
			TriggerClientEvent('esx:showNotification', source, Translation[Config.Locale]['add_blip'])
		else
			TriggerClientEvent('SecretBlips:RemoveBlip', source)
			TriggerClientEvent('esx:showNotification', source, Translation[Config.Locale]['remove_blip'])
			IsEnabled = false
		end
	end)
	if Config.RemoveItem then
		AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
			local xPlayer = ESX.GetPlayerFromId(source)
			local item = xPlayer.getInventoryItem(Config.DrugItem)

			if item.name ~= nil and item.name == Config.DrugItem and item.count == 0 then
				IsEnabled = false
				TriggerClientEvent('SecretBlips:RemoveBlip', source)
				TriggerClientEvent('esx:showNotification', source, Translation[Config.Locale]['remove_blip'])
			end
		end)
	end
elseif Config.Framework:match('QBCore') then
	local QBCore = exports['qb-core']:GetCoreObject()

	local IsEnabled = false

	QBCore.Functions.CreateUseableItem(Config.DrugItem, function(source)
		if not IsEnabled then
			IsEnabled  = true
			TriggerClientEvent('SecretBlips:ShowBlipQB', source)
			TriggerClientEvent('QBCore:Client:Notify', source, Translation[Config.Locale]['add_blip'])
		else
			TriggerClientEvent('SecretBlips:RemoveBlipQB', source)
			TriggerClientEvent('QBCore:Client:Notify', source, Translation[Config.Locale]['remove_blip'])
			IsEnabled = false
		end
	end)

	if Config.RemoveItem then
		-- Do something here
	end
else
	print('ERROR: Framework not configured in config.lua')
end

---- Functions ----

function debug(msg)
	if Config.Debug then
		print(msg)
	end
end

---- GitHub Updater ----

function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

local CurrentVersion = GetCurrentVersion()
local resourceName = "^4["..GetCurrentResourceName().."]^0"

if Config.VersionChecker then
	PerformHttpRequest('https://raw.githubusercontent.com/Musiker15/SecretBlips/main/VERSION', function(Error, NewestVersion, Header)
		print("###############################")
    	if CurrentVersion == NewestVersion then
	    	print(resourceName .. '^2 ✓ Resource is Up to Date^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0')
    	elseif CurrentVersion ~= NewestVersion then
        	print(resourceName .. '^1 ✗ Resource Outdated. Please Update!^0 - ^5Current Version: ^1' .. CurrentVersion .. '^0')
	    	print('^5Newest Version: ^2' .. NewestVersion .. '^0 - ^6Download here: ^9https://github.com/Musiker15/SecretBlips/releases/tag/v'.. NewestVersion .. '^0')
    	end
		print("###############################")
	end)
else
	print("###############################")
	print(resourceName .. '^2 ✓ Resource loaded^0')
	print("###############################")
end
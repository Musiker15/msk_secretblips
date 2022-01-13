if Config.Framework:match('ESX') then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	local IsEnabled = false

	ESX.RegisterUsableItem(Config.DrugItem, function(source)
		if not IsEnabled then
			IsEnabled  = true
			TriggerClientEvent('SecretBlips:ShowBlip', source)
			TriggerClientEvent('esx:showNotification',source, _U('add_blip'))
		else
			TriggerClientEvent('SecretBlips:RemoveBlip', source)
			TriggerClientEvent('esx:showNotification', source, _U('remove_blip'))
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
				TriggerClientEvent('esx:showNotification', source, _U('remove_blip'))
			end
		end)
	end
elseif Config.Framework:match('QBCore') then
	local QBCore = exports['qb-core']:GetCoreObject()

	local IsEnabled = false

	QBCore.Functions.CreateUsableItem(Config.Drugitem, function(source)
		if not IsEnabled then
			IsEnabled  = true
			TriggerClientEvent('SecretBlips:ShowBlipQB', source)
			TriggerClientEvent(QBCore:Client:Notify, source, _U('add_blip'))
		else
			TriggerClientEvent('SecretBlips:RemoveBlipQB', source)
			TriggerClientEvent(QBCore:Client:Notify, source, _U('remove_blip'))
			IsEnabled = false
		end
	end)

	if Config.RemoveItem then
		AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
			local xPlayer = QBCore.Functions.GetPlayer(source)
			local item = xPlayer.Functions.GetItemByName(Config.DrugItem)

			if item.name ~= nil and item.name == Config.DrugItem and item.count == 0 then
				IsEnabled = false
				TriggerClientEvent('SecretBlips:RemoveBlipQB', source)
				TriggerClientEvent(QBCore:Client:Notify, source, _U('remove_blip'))
			end
		end)
	end
else
	print('ERROR: Framework not configured in config.lua')
end

---- GitHub Updater ----
function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

local CurrentVersion = GetCurrentVersion()
local resourceName = "^2["..GetCurrentResourceName().."]^0"

PerformHttpRequest('https://raw.githubusercontent.com/Musiker15/SecretBlips/main/VERSION', function(Error, NewestVersion, Header)
	print("###############################")
    if CurrentVersion == NewestVersion then
	    print(resourceName .. ' Resource is Up to Date.')
	    print('Current Version: ^2' .. CurrentVersion.. '^0')
    elseif CurrentVersion ~= NewestVersion then
        print(resourceName .. ' Resource Outdated. Please Update!')
	    print('Current Version: ^1' .. CurrentVersion .. '^0')
	    print('Newest Version: ^2' .. NewestVersion .. '^0')
        print('Download Newest Version here: https://github.com/Musiker15/SecretBlips/releases/tag/v' .. NewestVersion)
    end
	print("###############################")
end)
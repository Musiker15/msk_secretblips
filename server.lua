ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local IsEnabled = false

ESX.RegisterUsableItem(Config.DrugItem, function(source)
	if not IsEnabled then
		IsEnabled  = true
		TriggerClientEvent('SecretBlips:ShowBlip', source)
		TriggerClientEvent('esx:showNotification',source, "Drogenkarte aktiviert.")
	else
		TriggerClientEvent('SecretBlips:RemoveBlip', source)
		TriggerClientEvent('esx:showNotification', source, "Drogenkarte deaktiviert.")
		IsEnabled = false
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(Config.DrugItem)

	if item.name ~= nil and item.name == Config.DrugItem and item.count == 0 then
		IsEnabled = false
		TriggerClientEvent('SecretBlips:RemoveBlip', source)
		TriggerClientEvent('esx:showNotification', source, "Drogenkarte deaktiviert.")
	end
end)

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
	    print('## Current Version: ' .. CurrentVersion)
    elseif CurrentVersion ~= NewestVersion then
        print(resourceName .. ' Resource Outdated. Please Update!')
	    print('Current Version: ^1' .. CurrentVersion .. '^0')
	    print('Newest Version: ^2' .. NewestVersion .. '^0')
        print('## Download Newest Version here: https://github.com/Musiker15/SecretBlips/releases')
    end
	print("###############################")
end)
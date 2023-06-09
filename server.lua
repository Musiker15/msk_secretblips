if Config.Framework:match('ESX') then
	ESX = exports["es_extended"]:getSharedObject()

	for k, v in pairs(Config.BlipItems) do
		ESX.RegisterUsableItem(k, function(source)
			local src = source
			local xPlayer = ESX.GetPlayerFromId(src)
	
			xPlayer.triggerEvent('msk_secretblips:showBlip', k, v)
		end)
	end

	if Config.RemoveItem then
		AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
			local src = source
			local xPlayer = ESX.GetPlayerFromId(src)

			for k, v in pairs(Config.BlipItems) do
				if item == k then
					xPlayer.triggerEvent('msk_secretblips:showBlip', k, v, true)
					break
				end
			end
		end)
	end
elseif Config.Framework:match('QBCore') then
	QBCore = exports['qb-core']:GetCoreObject()

	for k, v in pairs(Config.BlipItems) do
		QBCore.Functions.CreateUseableItem(k, function(source)
			local Player = QBCore.Functions.GetPlayer(source)

			TriggerClientEvent('msk_secretblips:showBlip', source, k, v)
		end)
	end

	if Config.RemoveItem then
		AddEventHandler('msk_secretblips:onRemoveItem', function(playerId, item, amount)
			for k, v in pairs(Config.BlipItems) do
				if item == k then
					TriggerClientEvent('msk_secretblips:showBlip', playerId, k, v, true)
					break
				end
			end
		end)
	end
end

GithubUpdater = function()
    GetCurrentVersion = function()
	    return GetResourceMetadata( GetCurrentResourceName(), "version" )
    end
    
    local CurrentVersion = GetCurrentVersion()
    local resourceName = "^4["..GetCurrentResourceName().."]^0"

    if Config.VersionChecker then
        PerformHttpRequest('https://raw.githubusercontent.com/Musiker15/msk_secretblips/main/VERSION', function(Error, NewestVersion, Header)
            print("###############################")
            if CurrentVersion == NewestVersion then
                print(resourceName .. '^2 ✓ Resource is Up to Date^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0')
            elseif CurrentVersion ~= NewestVersion then
                print(resourceName .. '^1 ✗ Resource Outdated. Please Update!^0 - ^5Current Version: ^1' .. CurrentVersion .. '^0')
                print('^5Newest Version: ^2' .. NewestVersion .. '^0 - ^6Download here:^9 https://github.com/Musiker15/msk_secretblips/releases/tag/v'.. NewestVersion .. '^0')
            end
            print("###############################")
        end)
    else
        print("###############################")
        print(resourceName .. '^2 ✓ Resource loaded^0')
        print("###############################")
    end
end
GithubUpdater()
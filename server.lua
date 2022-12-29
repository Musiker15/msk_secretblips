AddEventHandler('onResourceStart', function(resource)
	if GetCurrentResourceName() ~= 'msk_secretblips' then
        print('^1Please rename the Script to^3 msk_secretblips^0!')
        print('^1Server will be shutdown^0!')
        os.exit()
    end
end)

if Config.Framework:match('ESX') then
	ESX = exports["es_extended"]:getSharedObject()

	for k,v in pairs(Config.BlipItems) do
		ESX.RegisterUsableItem(k, function(source)
			local src = source
			local xPlayer = ESX.GetPlayerFromId(src)
	
			xPlayer.triggerEvent('msk_secretblips:showBlip', k, v)
		end)
	
		if Config.RemoveItem then
			AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
				local src = source
				local xPlayer = ESX.GetPlayerFromId(src)
	
				if item == k then
					xPlayer.triggerEvent('msk_secretblips:showBlip', k, v, true)
				end
			end)
		end
	end
elseif Config.Framework:match('QBCore') then
	QBCore = exports['qb-core']:GetCoreObject()

	for k,v in pairs(Config.BlipItems) do
		QBCore.Functions.CreateUseableItem(k, function(source)
			local Player = QBCore.Functions.GetPlayer(source)

			TriggerClientEvent('msk_secretblips:showBlip', source, k, v)
		end)

		if Config.RemoveItem then
			-- Add your own Code here
		end
	end
end

function debug(msg, msg2, msg3)
	if Config.Debug then
		if msg3 then
			print('[DEBUG]', msg, msg2, msg3)
        elseif msg2 and not msg3 then
            print('[DEBUG]', msg, msg2)
        else
		    print('[DEBUG]', msg)
        end
	end
end

---- GitHub Updater ----

function GetCurrentVersion()
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
	    	print('^5Newest Version: ^2' .. NewestVersion .. '^0 - ^6Download here: ^9https://github.com/Musiker15/msk_secretblips/releases/tag/v'.. NewestVersion .. '^0')
    	end
		print("###############################")
	end)
else
	print("###############################")
	print(resourceName .. '^2 ✓ Resource loaded^0')
	print("###############################")
end
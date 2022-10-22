if Config.Framework:match('ESX') then
	ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework:match('QBCore') then
	QBCore = exports['qb-core']:GetCoreObject()
end

local Blips = {}
local timerActive = {}

RegisterNetEvent('msk_secretblips:showBlip')
AddEventHandler('msk_secretblips:showBlip', function(itemName, blipTable, remove)
	if not table.contains(itemName, remove) then
		Blips[itemName] = {}

		for k, v in pairs (blipTable) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			SetBlipSprite(blip, v.blip)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.scale)
			SetBlipColour(blip, v.color)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.display)
			EndTextCommandSetBlipName(blip)

			table.insert(Blips[itemName], {
				name = itemName,
				blip = blip
			})
		end

		if Config.Framework:match('ESX') then
			ESX.ShowNotification(Translation[Config.Locale]['add_blip'] .. itemName)
		elseif Config.Framework:match('QBCore') then
			QBCore.Functions.Notify(Translation[Config.Locale]['add_blip'] .. itemName, 'primary', 5000)
		end
		startTimer(itemName, blipTable)
	else
		if not Blips[itemName] then return end

		for k, v in pairs(Blips[itemName]) do
			if itemName == v.name then
				RemoveBlip(v.blip)
				Blips[itemName] = nil
			end
		end

		if timerActive[itemName] then
			debug('STOP Timer')
			timerActive[itemName] = false
		end

		if Config.Framework:match('ESX') then
			ESX.ShowNotification(Translation[Config.Locale]['remove_blip'] .. itemName)
		elseif Config.Framework:match('QBCore') then
			QBCore.Functions.Notify(Translation[Config.Locale]['remove_blip'] .. itemName, 'primary', 5000)
		end
	end
end)

function table.contains(itemName, remove)
	if remove then return true end

	if not Blips[itemName] then
		debug('table.contains false')
		return false
	else
		debug('table.contains true')
		return true
	end
end

function startTimer(itemName, blipTable)
	if Config.EnableBlipTime then
		timerActive[itemName] = true
		debug('START Timer')
		Wait(Config.BlipTime * 1000)
		if timerActive[itemName] then
			debug('STOP Timer')
			timerActive[itemName] = false
			TriggerEvent('msk_secretblips:showBlip', itemName, blipTable)
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
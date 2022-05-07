if Config.Framework:match('ESX') then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
    	end
	end)

	local state = false
	local Blips = {}

	RegisterNetEvent('SecretBlips:ShowBlip')
	AddEventHandler('SecretBlips:ShowBlip', function()
		state = true

		for k,v in pairs (Config.SecretBlips) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			SetBlipSprite(blip, v.blip)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.scale)
			SetBlipColour(blip, v.color)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.display)
			EndTextCommandSetBlipName(blip)
			table.insert(Blips, blip)
		end

		if Config.EnableBlipTime then
			Citizen.Wait(Config.BlipTime * 1000)
			TriggerEvent('SecretBlips:RemoveBlip')
		end
	end)

	RegisterNetEvent('SecretBlips:RemoveBlip')
	AddEventHandler('SecretBlips:RemoveBlip', function()
		state = false

		for i=1, #Blips, 1 do
			RemoveBlip(Blips[i])
			Blips[i] = nil
		end
	end)
elseif Config.Framework:match('QBCore') then
	local QBCore = exports['qb-core']:GetCoreObject()
	--[[ Citizen.CreateThread(function()
   		while QBCore == nil do
   			TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
   			Citizen.Wait(0)
   		end
	end) ]]

	local state = false
	local Blips = {}

	RegisterNetEvent('SecretBlips:ShowBlipQB')
	AddEventHandler('SecretBlips:ShowBlipQB', function()
		state = true

		for k,v in pairs (Config.SecretBlips) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			SetBlipSprite(blip, v.blip)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.scale)
			SetBlipColour(blip, v.color)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.display)
			EndTextCommandSetBlipName(blip)
			table.insert(Blips, blip)
		end

		if Config.EnableBlipTime then
			Citizen.Wait(Config.BlipTime)
			TriggerEvent('SecretBlips:RemoveBlipQB')
		end
	end)

	RegisterNetEvent('SecretBlips:RemoveBlipQB')
	AddEventHandler('SecretBlips:RemoveBlipQB', function()
		state = false

		for i=1, #Blips, 1 do
			RemoveBlip(Blips[i])
			Blips[i] = nil
		end
	end)
else
	print('ERROR: Framework not configured in config.lua')
end

---- Functions ----

function debug(msg)
	if Config.Debug then
		print(msg)
	end
end
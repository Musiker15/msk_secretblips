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
end)

RegisterNetEvent('SecretBlips:RemoveBlip')
AddEventHandler('SecretBlips:RemoveBlip', function()
	state = false

	for i=1, #Blips, 1 do
		RemoveBlip(Blips[i])
		Blips[i] = nil
	end
end)
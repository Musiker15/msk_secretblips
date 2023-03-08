# MSK SecretBlips
[ESX/QBCore] Show and delete Blips with an item

**FiveM Forum:** https://forum.cfx.re/t/release-esx-secretblips-make-blips-visible-with-an-item/4795682

**Discord Support:** https://discord.gg/5hHSBRHvJE

## Description
* You can set the Item you want to use.
* You can set the Blips that you want to show after using the item.
* Blips will be removed if you drop the item.

## Setup for QBCore
* Go to `qb-inventory/server/main.lua` and search for `function RemoveItem`
* Add the following `TriggerEvent()` before every `return true`
```lua
TriggerEvent('msk_secretblips:onRemoveItem', Player.PlayerData.source, item, amount)
```
<details>
<summary>If you don't get it then look at this Code</summary>
<br>
	local function RemoveItem(source, item, amount, slot)
		local Player = QBCore.Functions.GetPlayer(source)

		if not Player then return false end

		amount = tonumber(amount) or 1
		slot = tonumber(slot)

		if slot then
			if Player.PlayerData.items[slot].amount > amount then
				Player.PlayerData.items[slot].amount = Player.PlayerData.items[slot].amount - amount
				Player.Functions.SetPlayerData("items", Player.PlayerData.items)

				if not Player.Offline then
					TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. Player.PlayerData.items[slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[slot].amount)
				end
				
				TriggerEvent('msk_secretblips:onRemoveItem', Player.PlayerData.source, item, amount)
				return true
			elseif Player.PlayerData.items[slot].amount == amount then
				Player.PlayerData.items[slot] = nil
				Player.Functions.SetPlayerData("items", Player.PlayerData.items)

				if Player.Offline then return true end

				TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')
				TriggerEvent('msk_secretblips:onRemoveItem', Player.PlayerData.source, item, amount)
				return true
			end
		else
			local slots = GetSlotsByItem(Player.PlayerData.items, item)
			local amountToRemove = amount

			if not slots then return false end

			for _, _slot in pairs(slots) do
				if Player.PlayerData.items[_slot].amount > amountToRemove then
					Player.PlayerData.items[_slot].amount = Player.PlayerData.items[_slot].amount - amountToRemove
					Player.Functions.SetPlayerData("items", Player.PlayerData.items)

					if not Player.Offline then
						TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. _slot .. '], itemname: ' .. Player.PlayerData.items[_slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[_slot].amount)
					end
					TriggerEvent('msk_secretblips:onRemoveItem', Player.PlayerData.source, item, amount)
					return true
				elseif Player.PlayerData.items[_slot].amount == amountToRemove then
					Player.PlayerData.items[_slot] = nil
					Player.Functions.SetPlayerData("items", Player.PlayerData.items)

					if Player.Offline then return true end

					TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. _slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')
					TriggerEvent('msk_secretblips:onRemoveItem', Player.PlayerData.source, item, amount)
					return true
				end
			end
		end
		return false
	end
</details>


## Requirements
* ESX 1.2 and above or QBCore

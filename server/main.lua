ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------------------------------------------------------[HUNTING]------------------------------------------------------------

RegisterServerEvent('Jerry_hunting:server:Check')
AddEventHandler('Jerry_hunting:server:Check', function(itemName, count)
	print('Check Loop ')
end)

RegisterServerEvent('Jerry_hunting:server:addItems')
AddEventHandler('Jerry_hunting:server:addItems', function(itemName, count)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local i = xPlayer.getInventoryItem(itemName)
	local i2 = itemName
    local c = count
    local x2 = xPlayer.getInventoryItem(Config.x2)
	
	if Config.Base == '1.1' then
		if i.limit ~= -1 and i.count >= i.limit then
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = Config.Text['header_text'],
				type = "error",
				timeout = 5000,
				text = "<strong class='red-text'><center>"..Config.Text['item_limit'].."<center></strong>",--bottomCenter <Center>
				layout = "centerLeft",
				queue = "global"
			})
		else
			if i.limit ~= -1 and (i.count + c) > i.limit then
				xPlayer.setInventoryItem(i.name, i.limit)
			else
				xPlayer.addInventoryItem(i.name, c)
			end

			for k,v in pairs(Config.Animals) do
				if v.items.bonus ~= nil then
					for k,v in pairs(v.items.bonus) do
						if math.random(1, 100) <= v.bonusdroprate then
							local xPlayer = ESX.GetPlayerFromId(source)
							local itn = v.itembonus
							local itc = math.random(v.bonuscount[1], v.bonuscount[2]) 
							
							if itn.limit ~= -1 and itn.count >= itn.limit then
								TriggerClientEvent("pNotify:SendNotification", source, {
									text = '<span class="red-text">'..Config.Text['item_bonus_limit']..'</span> ',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							else
								if itn.limit ~= -1 and (itn.count + itc) > itn.limit then
									xPlayer.setInventoryItem(itn.name, itn.limit)
								else
									xPlayer.addInventoryItem(itn.name, itc)						
								end
							end
						end
					end
				end
			end
		end
	elseif Config.Base == '1.2' then
		if xPlayer.canCarryItem(i2, c) then 
			for k,v in pairs(Config.Animals) do
				if v.items.bonus ~= nil then
					for k,v in pairs(v.items.bonus) do
						if math.random(1, 100) <= v.bonusdroprate then
							local xPlayer = ESX.GetPlayerFromId(source)
							local itn = v.itembonus
							local itc = math.random(v.bonuscount[1], v.bonuscount[2]) 
							
							if xPlayer.canCarryItem(itn, itc) then 
								xPlayer.addInventoryItem(itn, itc)
								return
							else
								TriggerClientEvent("pNotify:SendNotification", source, {
									text = '<span class="red-text">'..Config.Text['item_bonus_weight']..'</span> ',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
								return
							end
						end
					end
				end
			end
		else
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = '<span class="red-text">'..Config.Text['item_bonus_weight']..'</span> ',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		end
	end
end)

-------------------------------------------------------------[VEHICLE]------------------------------------------------------------
RegisterNetEvent('Jerry_hunting:server:SpawnVehicle')
AddEventHandler('Jerry_hunting:server:SpawnVehicle', function(currentVehicle, currentPrice)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() < currentPrice then 
		TriggerClientEvent('Jerry_hunting:noMoney', source)
	else
		TriggerClientEvent("Jerry_hunting:Spawnvehicle", source, currentVehicle)
		xPlayer.removeMoney(currentPrice)
		print('server')
	end
end)

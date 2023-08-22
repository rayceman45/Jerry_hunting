ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local search = {}
local pedCoords = 0
local dist = 0

local itemname = nil
local itemcount = nil
local itembonus = nil
local bonuscount = nil

local animalModels = {}
local animalsSpawnedCount = 0

local animalFleeing = {}
local fleeFound = false

local checkzone = true
local checkentity = false

local player = nil
local coords = {}

------------------------------------------------------------[MAIN]------------------------------------------------------------

Citizen.CreateThread(function()
    SetForcePedFootstepsTracks(true)
    while true do
        player = PlayerPedId(-1)
        coords = GetEntityCoords(player)

        Citizen.Wait(1000)      
        if checkentity then
            Citizen.Wait(400)
            if #search > 0 then
                for i, ped in pairs(search) do
                    local distancePedPlayer = getDistance(ped)
                    if distancePedPlayer < Config.PNearAnimalToEscape and not IsPedStill(player) then
                        for i,pedFlee in pairs(animalFleeing) do
                            if ped == pedFlee then
                                fleeFound = true
                            else
                                fleeFound = false
                            end
                        end
                        if not fleeFound then
                            TaskSmartFleePed(ped, player, 20.0, 5.0, true, true)
                            table.insert(animalFleeing, ped)
                        end
                    elseif distancePedPlayer > Config.HuntRadious then
                        deletePed(ped, i)
                    end
                    --SetBlockingOfNonTemporaryEvents(ped, true)
                end
            end
        end
    end
end)

------------------------------------------------------------[FUNCTION]------------------------------------------------------------

function isNearAnAnimal(dist, ped, i)
    if IsControlJustReleased(0, 38) then
        local model = GetEntityModel(ped)
        local animal = getAnimalMatch(model)
        if GetPedSourceOfDeath(ped) == player then
            harvestAnimal(ped, animal, i)
        else
            exports["mythic_notify"]:SendAlert("error", Config.Text['you_didnt_kill_it'], 10000)
        end
    end  
end

function HasKnife()
    for i, knife in pairs(Config.KnifesForHarvest) do
        if GetHashKey(knife) == GetSelectedPedWeapon(player) then
            return true
        end
    end
    return false
end

function harvestAnimal(ped, model, i)
    if HasKnife() or not Config.NeedHarvest then
        for k, v in pairs(Config.Animals) do
            if v.model == model then
                itemname = v.items.itemname
                leatherToGiveCount = math.random(v.items.itemcount[1], v.items.itemcount[2]) 
                itemdroprate = v.items.itemdroprate
            end
        end

        SetCurrentPedWeapon(player, -1569615261, true)
        TaskTurnPedToFaceEntity(player, ped, -1)
        ensureAnimDict("amb@medic@standing@kneel@base")
        TaskPlayAnim(player, "amb@medic@standing@kneel@base", "base", 1.0, -1.0, -1, 1, 0, false, false, false)
        ensureAnimDict("anim@gangops@facility@servers@bodysearch@")
        TaskPlayAnim(player, "anim@gangops@facility@servers@bodysearch@", "player_search" ,1.0, -1.0, -1, 1, 0, false, false, false)                       
        TriggerEvent("mythic_progbar:client:progress", {
            name = Config.Text['harvesting'],
            duration = Config.TimeToHarvest,
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)
            if not status then
                -- Do Something If Event Wasn't Cancelled
            end
        end)
        Citizen.Wait(Config.TimeToHarvest)
        ClearPedTasks(player)

        local random = math.random(0,100)
        if random <= itemdroprate then
            TriggerServerEvent('Jerry_hunting:server:addItems', itemname, leatherToGiveCount)
        end

        Citizen.Wait(1000)
        deletePed(ped, i)
        Citizen.Wait(3000)
    else
        exports['mythic_notify']:SendAlert('error', Config.Text['need_knife'], 10000)
        Citizen.Wait(200)
    end
end

function deletePed(entity, i)
    local model = GetEntityModel(entity)
    SetEntityAsNoLongerNeeded(entity)
    SetModelAsNoLongerNeeded(model)
    DeleteEntity(entity)
    table.remove(search, i)
    animalsSpawnedCount = animalsSpawnedCount - 1
end

function animalExists(entity)
    for i, ped in pairs(search) do
        if ped == entity then
            return true 
        end
    end
    return false
end

function animalModelExists(entity)
    for i, ped in pairs(Config.Animals) do
        if ped.hash == GetEntityModel(entity) then
            return true
        end
    end
    return false
end

function getAnimalMatch(hash)
    for _, v in pairs(Config.Animals) do 
        if (v.hash == hash) then 
            return v.model
        end 
    end
end

function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(100)
        end        
    end
    return animDict
end

function IsInSpawnAnimalZone(coords)
    for k, v in pairs(Config.HuntPoint) do
        if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.HuntRadious then
            return true
        end
    end
    return false
end

function CheckEntityOutZone(entity)
    for k,v in pairs(Config.HuntPoint) do
        et = entity
        gec = GetEntityCoords(et)
        if GetDistanceBetweenCoords(gec, v.x, v.y, v.z, true) > 50 then
            for i, entity in pairs(search) do
                deletePed(entity, i)
                print('Check ENtity Out Zone')
            end
        end
    end
end

function RemovePedWeapon(coords)
    if Config.WeaponRemoveO then
        if checkzone then
            for k, v in pairs(Config.HuntPoint) do
                if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) > Config.RadiousWeaponremove then
                    local CheckWeaponP = GetHashKey(Config.Weaponremove)
                    if HasPedGotWeapon(GetPlayerPed(-1), CheckWeaponP, false) then
                        haveWeapon = true
                    end

                    if haveWeapon == true then
                        RemoveWeaponFromPed(player, GetHashKey(Config.Weaponremove), true)
                        exports["mythic_notify"]:SendAlert("success", Config.Text['remove_weapon'], 4 * 1000)
                        checkzone = false
                        haveWeapon = false
                    end
                end
            end
        end
    end
end

function getDistance(pedToGetCoords)
    pedCoords = GetEntityCoords(pedToGetCoords, true)
    local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, pedCoords.x, pedCoords.y, pedCoords.z)
    return dist
end

------------------------------------------------------------[MAIN]------------------------------------------------------------

Citizen.CreateThread(function()
    for i, animal in pairs(Config.Animals) do
        table.insert(animalModels, animal.model)
    end
    while true do
        local sleep = 1000
        local pos = coords
        local land = false
        local X,Y,Zc = 0
        local ped = PlayerPedId()

        if IsInSpawnAnimalZone(pos) then
            sleep = 0
            checkzone = true
            checkentity = true
            if Config.DisableCombatPlayer then
                SetPlayerInvincible(ped, true)
            end
            if animalsSpawnedCount < Config.SpawnAnimalNumber then
                for k, v in pairs(Config.HuntPoint) do
                    if GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < Config.HuntRadious then
                        X = v.x
                        Y = v.y
                        Zc = v.z
                    end
                end

                

                local r = math.random(1, #animalModels)
                local pr = math.random(1, 100)
                local pedModel = GetHashKey(animalModels[r])
                RequestModel(pedModel)
                while not HasModelLoaded(pedModel) or not HasCollisionForModelLoaded(pedModel) do
                    Wait(100)
                end
                
                posX = X + math.random(Config["spawnrandomX"][1], Config["spawnrandomX"][2])
                Citizen.Wait(100)
                posY = Y + math.random(Config["spawnrandomY"][1], Config["spawnrandomY"][2])
                Z = Zc + 999.0

                land,posZ = GetGroundZFor_3dCoord(posX + .0, posY + .0, Z, 1)
                if land then
                    entity = CreatePed(5, pedModel, posX, posY, posZ, 0.0, false, false)
                    animalsSpawnedCount = animalsSpawnedCount + 1
                    SetEntityHealth(entity, 150)
                    TaskWanderStandard(entity, true, true)
                    SetEntityAsMissionEntity(entity, true, true)
                    table.insert(search, entity)
                    if Config.BlipOnEntity then
                        local blip = AddBlipForEntity(entity)

                        for k, v in pairs(Config.BlipsAnimals) do
                            addBlipAnimals(blip, v.sprite, v.colour, v.scale, v.name)
                        end
                    end
                end
                --CheckEntityOutZone(entity)
            end
        else
            for i, entity in pairs(search) do
                deletePed(entity, i)
            end
            animalsSpawnedCount = 0

            if Config.DisableCombatPlayer then
                SetPlayerInvincible(ped, false)
            end
        end

        for i, entity in pairs(search) do
            if IsEntityInWater(entity) then
                deletePed(entity, i)
            end
        end
        RemovePedWeapon(pos)
        Citizen.Wait(sleep)
    end
end)

------------------------------------------------------------[DRAWTEXT]------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        
        for i = 1, #search, 1 do
            local ped = search[i]
            local distancePedPlayer = getDistance(ped)
            if distancePedPlayer < 3.0 and not IsPedInAnyVehicle(player, false) and IsPedDeadOrDying(ped, true) then
                if IsInSpawnAnimalZone(pedCoords) then
                    sleep = 0
                    DrawText3Ds(pedCoords.x, pedCoords.y, pedCoords.z + 0.5, Config.Text['before_harvest'])
                    isNearAnAnimal(distancePedPlayer, ped, i)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterFontFile('font4thai')
fontId = RegisterFontId('font4thai')

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local scale = 0.5
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

-------------------------------------------------------------[BLIPS]------------------------------------------------------------

function addBlip(coords, sprite, colour, scale, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

function addBlipAnimals(blip, sprite, colour, scale, name)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
    if Config.BlipsO then
        for k, v in pairs(Config.Blips) do
            addBlip(v.coords, v.sprite, v.colour, v.scale, v.name)
        end
    end
    if Config.ShopBlipsO then
        for k, v in pairs(Config.ShopBlips) do
            addBlip(v.coords, v.sprite, v.colour, v.scale, v.name)
        end
    end
end)

-------------------------------------------------------------[VEHICLE]------------------------------------------------------------

local PlayerData = {}
local allVehicleSpawn = false

local display = false
local isShopOpen = false
local inmarker = false
local currentVehicle = Config.Vehicle.VehicleModel
local currentPrice = Config.Vehicle.VehiclePrice

Citizen.CreateThread(function()
    if Config.ShopMarkerO then
        while true do 
            local sleep = 1000
            local coords = GetEntityCoords(PlayerPedId())

            for k,v in pairs(Config.ShopMarker) do 
                if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, false) < Config.MarkerDistance then
                    DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Colour.r, v.Colour.g, v.Colour.b, 110, 0, 1, 0, 1)
                    sleep = 0
                elseif GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, false) > Config.MarkerDistance then
                    sleep = 1000
                end
            end
            Citizen.Wait(sleep)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local coords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(Config.ShopMarker) do
            if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, false) < v.Size.x then
                sleep = 7
                inmarker = true
                if not isShopOpen then
                    ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to open shop")
                end
            else
                inmarker = false
            end     
        end     

        if inmarker and not isShopOpen then
            sleep = 7
            if IsControlJustReleased(0, 38) then
                if isShopOpen == false then

                    SetDisplay(not display)
                    isShopOpen = true
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- Create NPC
local NPCList = {}
Citizen.CreateThread(function()
    if Config.NPCO then
        for k,v in pairs(Config.NPC) do
            if v.NPC then
                local x,y,z = table.unpack(v.coords)
                RequestModel(GetHashKey(v.NPC.Model))
                while not HasModelLoaded(GetHashKey(v.NPC.Model)) do
                    Wait(1)
                end
                playerPed = CreatePed(4, v.NPC.Model, x, y, z - 1.0, v.NPC.heading, false, true)
                FreezeEntityPosition(playerPed, true)
                SetEntityInvincible(playerPed, true)
                SetBlockingOfNonTemporaryEvents(playerPed, true)

                -- Play Animation
                if v.NPC.Animation then
                    if v.NPC.Animation.Scenario then
                        TaskStartScenarioInPlace(playerPed, v.NPC.Animation.AnimationScene, 0, false)
                    else
                        RequestAnimDict(v.NPC.Animation.AnimationDirect)
                        while (not HasAnimDictLoaded(v.NPC.Animation.AnimationDirect)) do Citizen.Wait(0) end
                        Wait(100)
                        TaskPlayAnim(playerPed, v.NPC.Animation.AnimationDirect, v.NPC.Animation.AnimationScene, 20.0, -20.0, -1, 1, 0, false, false, false)						
                    end
                end

                table.insert(NPCList, playerPed)
            end
        end
    end
end)

RegisterNetEvent("Jerry_hunting:Spawnvehicle")
AddEventHandler("Jerry_hunting:Spawnvehicle", function(currentVehicle)
    local coords = Config.VehicleSpawnLocation
    local handling = Config.VehicleSpawnLocationh
    local model = Config.Vehicle.VehicleModel
    local ped = GetPlayerPed(PlayerId())

    if currentVehicle == Config.Vehicle.VehicleModel then 
        print('spawn vehicle')
        ESX.Game.SpawnVehicle(model, coords, handling, function(vehicle)
            TaskWarpPedIntoVehicle(ped, vehicle, -1)
        end)
    else
        local weapon = Config.Weapon.Weapon
        local ammo = Config.Weapon.Ammo
        GiveWeaponToPed(ped, weapon, ammo, false, false)
        exports["mythic_notify"]:SendAlert("success", Config.Text['rent_weapon'], 5000)
    end
end)


-------------------------------------------------------------[UI]------------------------------------------------------------

--very important cb 
RegisterNUICallback("exit", function(data)
    isShopOpen = false
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end


RegisterNUICallback("askAccept", function(data)
    TriggerServerEvent("Jerry_hunting:server:SpawnVehicle",currentVehicle, currentPrice)
    isShopOpen = false
    SetDisplay(false)
    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
end)

RegisterNUICallback("rentvehicle", function(data)
    currentVehicle = Config.Vehicle.VehicleModel   
    currentPrice = Config.Vehicle.VehiclePrice
end)

RegisterNUICallback("rentweapon", function(data)
    currentVehicle = Config.Weapon.Weapon
    currentPrice = Config.Weapon.WeaponPrice   
end)

-------------------------------------------------------------[OTHER]------------------------------------------------------------

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        for i, ped in pairs(search) do
            SetEntityAsNoLongerNeeded(ped)
            DeleteEntity(ped)
        end
        for k,v in pairs(NPCList) do
            DeletePed(v)
        end
	end
end)





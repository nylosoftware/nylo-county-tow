local secondsUntilTow = Config.TowIntervalMinutes * 60
local towInProgress = false
local notifiedTimes = {}

local function notifyAllClients(messageConfig, ...)
    local args = {...}
    local message = {}
    for k, v in pairs(messageConfig) do
        message[k] = v
    end
    if #args > 0 then
        message.description = string.format(message.description, unpack(args))
    end
    print(string.format("[County Tow] Sending notification: %s - %s", message.title, message.description))
    TriggerClientEvent('Nylo-county-tow:client:showNotification', -1, message)
end

local function isVehicleExcluded(vehicle)
    local model = GetEntityModel(vehicle)

    for _, excludedModel in ipairs(Config.ExcludeVehicleModels) do
        if model == excludedModel then
            return true
        end
    end

    return false
end

local function performTow()
    if towInProgress then return end
    towInProgress = true
    print("[County Tow] Starting vehicle cleanup.")
    notifyAllClients(Config.Messages.started)

    local vehicles = GetGamePool('CVehicle')
    local deletedCount = 0

    for _, vehicle in ipairs(vehicles) do
        if DoesEntityExist(vehicle) then
            local pedInDriverSeat = GetPedInVehicleSeat(vehicle, -1)
            local occupied = false
            
            if pedInDriverSeat and pedInDriverSeat ~= 0 and IsPedAPlayer(pedInDriverSeat) then
                occupied = true
            end

            if not occupied and not isVehicleExcluded(vehicle) then
                DeleteEntity(vehicle)
                deletedCount = deletedCount + 1
            end
        end
    end

    print(string.format("[County Tow] Cleanup finished. Deleted %d vehicles.", deletedCount))
    notifyAllClients(Config.Messages.complete)
    towInProgress = false
    secondsUntilTow = Config.TowIntervalMinutes * 60
    notifiedTimes = {}
end

Citizen.CreateThread(function()
    print("[County Tow] Timer started. Next tow in " .. Config.TowIntervalMinutes .. " minutes.")
    while true do
        Citizen.Wait(1000)

        if not towInProgress then
            secondsUntilTow = secondsUntilTow - 1

            local minutesRemaining = math.ceil(secondsUntilTow / 60)
            if minutesRemaining > 1 then
                for _, notifyMin in ipairs(Config.NotificationMinutes) do
                    if minutesRemaining == notifyMin and not notifiedTimes[notifyMin] then
                        notifyAllClients(Config.Messages.warning, minutesRemaining)
                        notifiedTimes[notifyMin] = true
                        break
                    end
                end
            elseif secondsUntilTow > 0 and secondsUntilTow <= 60 then
                 if secondsUntilTow == 60 or secondsUntilTow == 30 or secondsUntilTow == 10 or secondsUntilTow == 5 or secondsUntilTow <= 1 then
                     notifyAllClients(Config.Messages.countdown, secondsUntilTow)
                 end
            elseif secondsUntilTow <= 0 then
                performTow()
            end
        end
    end
end)

RegisterCommand('countytow', function(source, args, rawCommand)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return end

    if exports.qbx_core:HasPermission(src, 'admin') then 
        if args[1] and string.lower(args[1]) == 'force' then
            if not towInProgress then
                print(string.format("[County Tow] Admin %s (%s) forced vehicle cleanup.", Player.PlayerData.name, src))
                exports.qbx_core:Notify(src, 'Manual county tow initiated.', 'primary')
                performTow()
            else
                exports.qbx_core:Notify(src, 'County tow is already in progress.', 'error')
            end
        else
            exports.qbx_core:Notify(src, 'Usage: /countytow force', 'error')
        end
    else
        exports.qbx_core:Notify(src, 'You do not have permission to use this command.', 'error')
    end
end, true) 
if not lib then
    error('ox_lib is required for Nylo-county-tow to function properly')
end

print('NyloSoftware')

RegisterNetEvent('Nylo-county-tow:client:showNotification', function(messageData)
    lib.notify(messageData)
end)

print('[Nylo-county-tow] Client-side initialized') 
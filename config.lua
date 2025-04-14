Config = {}

Config.AllowedJobs = {
    'police',
}

Config.Locale = {
    impound_vehicle = 'Impound Vehicle',
}

Config.TowIntervalMinutes = 60

Config.NotificationMinutes = {
    30,
    15,
    10,
    5,
    1
}

Config.Messages = {
    warning = {
        id = 'county_tow_warning',
        title = 'County Tow Alert',
        description = 'Vehicle cleanup scheduled in %s minutes. Please secure unattended vehicles.',
        position = 'right-center',
        style = {
            backgroundColor = '#FFA500',
            color = '#000000'
        },
        icon = 'fas fa-truck-pickup',
        duration = 15000,
    },
    countdown = {
        id = 'county_tow_countdown',
        title = 'County Tow Imminent',
        description = 'Vehicle cleanup commencing in %s seconds!',
        position = 'right-center',
        style = {
            backgroundColor = '#FF4500',
            color = '#FFFFFF'
        },
        icon = 'fas fa-exclamation-triangle',
        duration = 2000,
    },
    started = {
        id = 'county_tow_started',
        title = 'County Tow In Progress',
        description = 'Vehicle cleanup has commenced. Removing unattended vehicles...',
        position = 'right-center',
        style = {
            backgroundColor = '#DC143C',
            color = '#FFFFFF'
        },
        icon = 'fas fa-broom',
        duration = 10000,
    },
    complete = {
        id = 'county_tow_complete',
        title = 'County Tow Complete',
        description = 'Vehicle cleanup finished.',
        position = 'right-center',
        style = {
            backgroundColor = '#228B22',
            color = '#FFFFFF'
        },
        icon = 'fas fa-check-circle',
        duration = 10000,
    }
}

Config.ExcludeVehicleClasses = {
    14,
    15,
    16,
}

Config.ExcludeVehicleModels = {
    `police`,
    `ambulance`,
} 
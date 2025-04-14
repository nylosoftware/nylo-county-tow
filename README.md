# Nylo County Tow System

A comprehensive vehicle management system for FiveM servers that automatically handles unattended vehicles through scheduled towing operations.

## Features

- Automated vehicle cleanup system
- Configurable tow intervals
- Multiple warning notifications before tow
- Job-based permissions
- Vehicle class and model exclusions
- Modern notification system using ox_lib

## Configuration

The system can be configured through `config.lua`:

- Set allowed jobs for tow operations
- Configure tow intervals and notification timings
- Customize notification messages and styles
- Define vehicle exclusions by class or model

## Dependencies

- ox_lib
- ESX/QBCore (Framework)

## Installation

1. Ensure you have the required dependencies installed
2. Place the resource in your server's resources folder
3. Add `ensure Nylo-county-tow` to your server.cfg
4. Configure the settings in config.lua to match your server's needs

## License

Copyright © 2024 NyloSoftware. All rights reserved. 

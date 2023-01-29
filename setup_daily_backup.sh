#!/bin/bash

## This script is intended to setup a daily backup of the minecraft server
## It will create a cron job that will run the backup script at the specified time every day

## time to run the backup script use 24 hour format
time="3:00"

## path to the backup script
backup_script_path="/home/minecraft/backup.sh"

## path to the minecraft server
minecraft_server_path="/home/minecraft/server"

## Ensure the backup script exists
if [ ! -f "$backup_script_path" ]; then
  echo "Error: Backup script not found at $backup_script_path"
  exit 1
fi

## Ensure the minecraft server path exists
if [ ! -d "$minecraft_server_path" ]; then
  echo "Error: Minecraft server path not found at $minecraft_server_path"
  exit 1
fi

## Extract the hour and minute values from the time string
hour=$(echo $time | cut -d':' -f1)
minute=$(echo $time | cut -d':' -f2)

## Add the cron job to run the backup script at the specified time
(crontab -l ; echo "$minute $hour * * * $backup_script_path") | crontab -

echo "Daily backup for minecraft server set up successfully"

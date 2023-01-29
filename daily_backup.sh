#!bin/bash

# This script is intended to backup the minecraft server 
# The script will create a tar.gz file of the minecraft server directory and save it to the backup directory
# the script will then sftp the backup file to the remote server
# the server will then clean up the local backup file

## path to the minecraft server
minecraft_server_path="/home/minecraft/server"

## path to the backup directory
backup_directory="/home/minecraft/backups"

## path to the sftp script
sftp_script_path="/home/minecraft/sftp_backup.sh"

## we will use .env to store the sftp credentials
## the .env file should be in the same directory as this script
## the .env file should contain the following variables
## SFTP_USER
## SFTP_PASSWORD
## SFTP_HOST
## SFTP_PORT
## SFTP_REMOTE_PATH
## SFTP_REMOTE_BACKUP_DIRECTORY

## Ensure the minecraft server path exists
if [ ! -d "$minecraft_server_path" ]; then
  echo "Error: Minecraft server path not found at $minecraft_server_path"
  exit 1
fi

## Ensure the backup directory exists
if [ ! -d "$backup_directory" ]; then
  echo "Error: Backup directory not found at $backup_directory"
  exit 1
fi

## Ensure the sftp script exists
if [ ! -f "$sftp_script_path" ]; then
  echo "Error: SFTP script not found at $sftp_script_path"
  exit 1
fi

## Ensure the .env file exists
if [ ! -f ".env" ]; then
  echo "Error: .env file not found"
  exit 1
fi

## Load the .env file
source .env

## Ensure the .env file contains the required variables
if [ -z "$SFTP_USER" ]; then
  echo "Error: SFTP_USER not set in .env file"
  exit 1
fi

if [ -z "$SFTP_PASSWORD" ]; then
  echo "Error: SFTP_PASSWORD not set in .env file"
  exit 1
fi

if [ -z "$SFTP_HOST" ]; then
  echo "Error: SFTP_HOST not set in .env file"
  exit 1
fi

if [ -z "$SFTP_PORT" ]; then
  echo "Error: SFTP_PORT not set in .env file"
  exit 1
fi

if [ -z "$SFTP_REMOTE_PATH" ]; then
  echo "Error: SFTP_REMOTE_PATH not set in .env file"
  exit 1
fi

if [ -z "$SFTP_REMOTE_BACKUP_DIRECTORY" ]; then
  echo "Error: SFTP_REMOTE_BACKUP_DIRECTORY not set in .env file"
  exit 1
fi

## Create the backup file name
backup_file_name="backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

## Create the backup file
tar -czf $backup_directory/$backup_file_name $minecraft_server_path

## Ensure the backup file was created
if [ ! -f "$backup_directory/$backup_file_name" ]; then
  echo "Error: Backup file not found at $backup_directory/$backup_file_name"
  exit 1
fi

## using sftp transfer the backup file to the remote server
sftp -oPort=$SFTP_PORT $SFTP_USER@$SFTP_HOST:$SFTP_REMOTE_PATH/$SFTP_REMOTE_BACKUP_DIRECTORY <<EOF
  put $backup_directory/$backup_file_name
  quit 
EOF

## Ensure the backup file was transferred to the remote server
if [ ! -f "$SFTP_REMOTE_PATH/$SFTP_REMOTE_BACKUP_DIRECTORY/$backup_file_name" ]; then
  echo "Error: Backup file not found at $SFTP_REMOTE_PATH/$SFTP_REMOTE_BACKUP_DIRECTORY/$backup_file_name"
  exit 1
fi

## Remove the local backup file
rm $backup_directory/$backup_file_name

## Ensure the local backup file was removed

if [ -f "$backup_directory/$backup_file_name" ]; then
  echo "Error: Backup file not removed at $backup_directory/$backup_file_name"
  exit 1
fi

echo "Backup completed successfully"

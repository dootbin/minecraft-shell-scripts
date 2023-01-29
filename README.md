# minecraft-shell-scripts

This is a collection of shell scripts for managing a Minecraft server.

## Production Start

production_start.sh is a script that will start a Minecraft server in production mode.

### Set up

1. set the executable bit on the script: `chmod +x production_start.sh`

### Usage

    `./production_start.sh [server jar]`

## Daily Backup

daily_backup.sh is a script that will backup a Minecraft server to a sftp server.

### Set up

1. set the executable bit on the script: `chmod +x daily_backup.sh`
2. make sure you have an .env file in the same directory as the script. The .env file should contain the following variables:

        SFTP_HOST=your_sftp_host
        SFTP_USER=your_sftp_user
        SFTP_PASSWORD=your_sftp_password
        SFTP_PORT=your_sftp_port
        SFTP_PATH=your_sftp_path

### Usage
    
        `./daily_backup.sh`

## Setup Daily Backup

setup_daily_backup.sh is a script that will set up a daily backup of a Minecraft server to a sftp server using the daily_backup.sh script.

### Set up

1. set the executable bit on the script: `chmod +x setup_daily_backup.sh`

### Usage

    `./setup_daily_backup.sh`
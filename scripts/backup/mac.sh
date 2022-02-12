#!/bin/bash
#
# Backups macOS keys and configuration to USB Drive
# (C) Bryce Thuilot 2022 <bryce@thuilot.io>
# License: GPL v3

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;32m'
NO_COLOR='\033[0m'


#######################################
# Sets global env variable BACKUP_DIR
# to external USB
# Globals:
#   BACKUP_DIR
# Arguments:
#   None
#######################################
function set_backup_dir {
    BACKUP_DIR=/Volumes/BACKUP
    [ ! -d $BACKUP_DIR ] && echo -e "${RED}ERROR${NO_COLOR}: Backup USB not found, exiting" && exit 1
}

#######################################
# Exports public and secret GPG key to
# BACKUP_DIR
# Globals:
#   BACKUP_DIR
# Arguments:
#   None
#######################################
function backup_gpg {
    echo "Backing up GPG keys..."
    # Create directory if doesn't exist
    mkdir -p $BACKUP_DIR/keys/gpg
    # Remove any keys already there
    rm $BACKUP_DIR/keys/gpg/*
    
    # Export public key
    gpg --armor --export bthuilot@gmail.com > $BACKUP_DIR/keys/gpg/public.asc
    # Export secret key
    gpg --armor --export-secret-keys bthuilot@gmail.com > $BACKUP_DIR/backup/keys/gpg/secret.asc
    echo -e "${GREEN}done${NO_COLOR}"
}

#######################################
# Compresses backgrounds and moves the 
# zip file to BACKUP_DIR
# Globals:
#   BACKUP_DIR
#   DOT_DIR
#   BACKGROUND_DIR
# Arguments:
#   None
#######################################
function backup_backgrounds {
    echo -n "Compressing backgrounds folder... "
    $DOT_DIR=~/github/dot
    $BACKGROUND_DIR=$DOT_DIR/backgrounds

    if [ ! -d $BACKUP_DIR ]; then
	echo -e "${YELLOW}WARNING${NO_COLOR}: Background directory not found, skipping"
    else
	zip -r $BACKUP_DIR/backgrounds.zip $BACKGROUND_DIR/*
	echo -e "${GREEN}done${NO_COLOR}"
    fi
}

###################
### Entry Point ###
###################

# Set backup directory
set_backup_dir

# Backup GPG Keys
backup_gpg

# Backup backgrounds
backup_backgrounds

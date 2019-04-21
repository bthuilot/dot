#!/bin/bash

### Update backup file

##############################
### Unpack previous backup ###
##############################

# Decrypt Backup file
if [ -f $HOME/backup.tar.gz.gpg ];then
  gpg --decrypt $HOME/backup.tar.gz.gpg > $HOME/backup.tar.gz
  rm $HOME/backup.tar.gz.gpg
  # Expand tar.gz file
  tar -xzf $HOME/backup.tar.gz -C ~
else 
  mkdir -p $HOME/backup/
  mkdir -p $HOME/backup/keys/
fi

###################
### Backup Keys ###
###################

## Move GPG Keys
mkdir -p $HOME/backup/keys/gpg
# Export public key
gpg --armor --export bthuilot@gmail.com > ~/backup/keys/gpg/public.asc
# Export secret key
gpg --armor --export-secret-keys bthuilot@gmail.com > ~/backup/keys/gpg/secret.asc

## Move SSH keys
mkdir -p $HOME/backup/keys/gpg
cp ~/.ssh/id* $HOME/backup/keys/ssh/

# Move to USB if attached
if [ -d "/Volumes/THUILOT" ]; then
    cp -r ~/backup/ /Volumes/THUILOT/
fi

CURRENT_DIR=$(pwd)
# Re-compress folder
cd $HOME
tar -czf backup.tar.gz backup
# Remove backup
rm -rf $HOME/backup
# Encrypt tar.gz
gpg -r bthuilot@gmail.com --encrypt $HOME/backup.tar.gz
# Remove tar.gz
rm -rf $HOME/backup.tar.gz

### Update Dot files
cd $CURRENT_DIR


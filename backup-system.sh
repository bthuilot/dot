
### Update backup file

# Decrypt Backup file
gpg --decrypt ~/backup.tar.gz.gpg > ~/backup.tar.gz
rm ~/backup.tar.gz.gpg
# Expand tar.gz file
tar -xzf ~/backup.tar.gz -C ~

## Move GPG Keys
# Export public key
gpg --armor --export bthuilot@gmail.com > ~/backup/keys/gpg/public.asc
# Export secret key
gpg --armor --export-secret-keys bthuilot@gmail.com > ~/backup/keys/gpg/secret.asc

# Move SSH keys
cp ~/.ssh/id* ~/backup/keys/ssh/

# Move to USB if attached
if [ -d "/Volumes/THUILOT" ]; then
    cp -r ~/backup/ /Volumes/THUILOT/
fi

CURRENT_DIR=$(pwd)
# Re-compress folder
cd ~
tar -czf backup.tar.gz backup
# Remove backup
rm -rf ~/backup
# Encrypt tar.gz
gpg -r bthuilot@gmail.com --encrypt ~/backup.tar.gz
# Remove tar.gz
rm -rf ~/backup.tar.gz

### Update Dot files
cd $CURRENT_DIR
# Update vim config
cp ~/.config/nvim/init.vim vim/

cp ~/.zshrc zsh/zshrc






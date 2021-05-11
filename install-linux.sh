#!/bin/bash

###############
# Directories #
###############

# Create Build
mkdir -p $HOME/build
# Create Config
mkdir -p $HOME/.config/

# Set Directories
DOT_DIR=$(pwd)
BUILD_DIR=$HOME/build
CONFIG_DIR=$HOME/.config

#########
# Build #
#########
cd $BUILD_DIR

# Install Trizen
if ! type "$trizen" > /dev/null; then
  git clone https://aur.archlinux.org/trizen.git
  cd trizen
  makepkg -si
fi


####################
# Install Pacakges #
####################
cd $HOME

# List packages
SYSTEM="zsh git wget vim neovim snapd xrandr"
WIRELESS="openssh networkmanager"
DISPLAY="xorg-server xorg xorg-apps xorg-init plymouth ssdm"
FONTS="ttf-fira-code"

# Install all packages
trizen -Syyu $SYSTEM $WIRELESS $DISPLAY $PACKAGES $SOUND $FUN $FONTS

# Enable 
sudo systemctl enable NetworkManager
sudo systemctl enable sddm-plymouth

#######
# ZSH #
#######

# Change to ZSH
chsh -s /usr/bin/zsh

## Download OhMyZsh
RUNZSH="no" sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## Download oxide theme
wget https://raw.githubusercontent.com/dikiaap/dotfiles/master/.oh-my-zsh/themes/oxide.zsh-theme -o ~/.oh-my-zsh/custom/themes/oxide.zsh-theme

rm $HOME/.zshrc
ln $DOT_DIR/zsh/linux.zsh $HOME/.zshrc

###########
# Polybar #
###########

ln -s $DOT_DIR/polybar/ $CONFIG_DIR/polybar

########
# Rofi #
########

mkdir -p $CONFIG_DIR/rofi
rm $CONFIG_DIR/rofi/config.rasi
ln $DOT_DIR/rofi/config.rasi $CONFIG_DIR/rofi/config.rasi

######
# i3 #
######

rm $CONFIG_DIR/i3/config
ln $DOT_DIR/i3/config $CONFIG_DIR/i3/config


#############
# alacritty #
#############

mkdir -p $CONFIG_DIR/alacritty
rm $CONFIG_DIR/alacritty/alacritty.yml
ln $DOT_DIR/alacritty/alacritty.yml $CONFIG_DIR/alacritty/alacritty.yml

##########
# Neovim #
##########

# Move config file
mkdir -p $HOME/.config/nvim/
ln vim/init.vim $HOME/.config/nvim/

# Set up vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

################
# SSH/GPG Keys #
################

read -p "Do you want to install files from USB [Y/n]" -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
  # Move SSH
  mkdir -p $HOME/.ssh
  cp $DOT_DIR/keys/ssh/* $HOME/.ssh/
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa

  # Move GPG
  gpg2 --import $DOT_DIR/keys/gpg/public.asc
  gpg2 --import $DOT_DIR/keys/gpg/secret.asc

  # Install git essentails
  read -p "Set up git as Bryce? [Y/n]" setUpGit
  if [[ setUpGit -ne 'n' ]]; then
    git config --global user.name "Bryce Thuilot"
    git config --global user.email bthuilot@gmail.com
    git config --global commit.gpgsign true
    git config --global gpg.program gpg2
    git config --global user.signingkey $(gpg2 --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')
  fi

fi

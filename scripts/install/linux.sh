#!/bin/bash
# Copyright (C) 2017-2025 Bryce Thuilot <bryce@thuilot.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the FSF, either version 3 of the License, or (at your option) any later version.
# See the LICENSE file in the root of this repository for full license text or
# visit: <https://www.gnu.org/licenses/gpl-3.0.html>.


#############
# Functions #
#############

# Install SSH/GPG Keys
function install_keys {
	USBLOCATION=/mnt/BACKUP/

	# SSH keys #
	############
	cp -r $USBLOCATION/keys/ssh $HOME/.ssh
	chmod 400 $HOME/.ssh/id_rsa

	# Start the ssh-agent in the background
	eval "$(ssh-agent -s)"
	# Add ssh key
	ssh-add -K ~/.ssh/id_rsa

	# GPG Keys #
	############
	gpg --import $USBLOCATION/keys/gpg/public.asc
	gpg --import $USBLOCATION/keys/gpg/secret.asc

	# Set up git
	git config --global user.name "Bryce Thuilot"
	git config --global user.email bthuilot@gmail.com
	git config --global commit.gpgsign true
	git config --global user.signingkey $(gpg --list-secret-keys --keyid-format LONG | grep sec | awk -F'/' '{print $2}' | awk -F' ' '{print $1}')
}

# Install i3
function install_i3 {
	trizen -S -no-confirm i3 compton
	rm $CONFIG_DIR/i3/config
	ln $DOT_DIR/i3/config $CONFIG_DIR/i3/config
}

# Install plasma
function install_plasma {
	trizen -S -no-confirm plasma-meta
}

###############
# Directories #
###############

# Set Directories
GITHUB_DIR=$HOME/github
DOT_DIR=$GITHUB_DIR/dot
BUILD_DIR=$HOME/build
CONFIG_DIR=$HOME/.config

# Create GitHub dir
mkdir -p $GITHUB_DIR
# Create Build
mkdir -p $BUILD_DIR
# Create Config
mkdir -p $CONFIG_DIR
# clone dot
git clone git@github.com:bthuilot/dot $DOT_DIR

#########
# Build #
#########
cd $BUILD_DIR

# Install git
sudo pacman -S git

# Install Trizen
if ! type "$trizen" >/dev/null; then
	git clone https://aur.archlinux.org/trizen.git
	cd trizen
	makepkg -si
fi

####################
# Install Pacakges #
####################

# List packages
SYSTEM="zsh wget vim neovim snapd xrandr"
WIRELESS="openssh networkmanager"
DISPLAY="xorg-server xorg xorg-apps xorg-init plymouth ssdm"
FONTS="ttf-fira-code"

# Install all packages
trizen -Syyu --no-confirm $SYSTEM $WIRELESS $DISPLAY $PACKAGES $SOUND $FUN $FONTS

# Enable
sudo systemctl enable NetworkManager
sudo systemctl enable sddm-plymouth

############
# Add keys #
############

# Set up SSH and GPG Keys
# Set up git
read -r -p "Install keys from USB [Y/n]" response
if [[ $response =~ ^(yes|y|Y| ) ]] || [[ -z $response ]]; then
	install_keys
fi

#######
# ZSH #
#######

# Change to ZSH
chsh -s /usr/bin/zsh

## Download OhMyZsh
RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

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

PS3="Select the DE/WM: "

select de in i3 plasma none; do

	case $de in
	i3)
		install_i3
		break
		;;
	plasma)
		install_plasma
		break
		;;
	none)
		break
		;;
	*)
		echo "Invalid option $REPLY"
		;;
	esac
done

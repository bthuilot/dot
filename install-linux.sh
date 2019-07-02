#!/bin/bash

DOT_DIR=$(pwd)

# Create build directory
mkdir $HOME/build
cd $HOME/build

# Install Trizen
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si

cd $HOME 

# Copy Files
mkdir -p ~/.config/


SYSTEM="zsh git wget vim neovim chromium snapd "
WIRELESS="openssh networkmanager network-manager-applet stalonetray wireless_tools"
DISPLAY="xorg-server xorg xorg-apps xorg-init plasma kde-applications plymouth ssdm sddm-kcm"
FONTS="ttf-fira-code ttf-google-fonts-git ttf-font-awesome"

# Install
trizen -Syyu $SYSTEM $WIRELESS $DISPLAY $PACKAGES $SOUND $FUN $FONTS

sudo systemctl enable NetworkManager

# Change to ZSH
chsh -s /usr/bin/zsh

## Download OhMyZsh
RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# RUBY :D

## Download and install
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

cd ~/.rbenv && src/configure && make -C src

# Init ruby
~/.rbenv/bin/rbenv init
cd $HOME

mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

#Install Ruby :)

VERSION="2.6.3"
rbenv install $VERSION

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

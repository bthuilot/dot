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
cd $HOME/build

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
SYSTEM="zsh git wget vim neovim chromium snapd "
WIRELESS="openssh networkmanager network-manager-applet stalonetray wireless_tools"
DISPLAY="xorg-server xorg xorg-apps xorg-init plasma kde-applications plymouth ssdm sddm-kcm"
FONTS="ttf-fira-code ttf-google-fonts-git ttf-font-awesome"

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
RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm $HOME/.zshrc
ln zsh/linux.zsh $HOME/.zshrc

###############
# ZSH Plugins #
###############

# Auto Suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


########
# Ruby #
########

# Build rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src

# Init rbenv
~/.rbenv/bin/rbenv init
cd $HOME

# Install ruby-build as plugin
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

eval "$(rbenv init -)"

################
# Install Ruby #
################

VERSION="2.6.3"
rbenv install $VERSION
rbenv global $VERSION
rbenv shell $VERSION

##########
# Neovim #
##########

# Move config file
mkdir -p $HOME/.config/nvim/
ln vim/init.vim $HOME/.config/nvim/

# Set up vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install neovim gem to use CommandT
gem install neovim

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

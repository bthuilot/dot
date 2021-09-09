#!/bin/bash

######################
### Identity files ###
######################

function install_keys {
  USBLOCATION=/Volumes/BACKUP/

  # SSH keys
  ##########
  cp -r $USBLOCATION/keys/ssh $HOME/.ssh
  chmod 400 $HOME/.ssh/id_rsa

  # Start the ssh-agent in the background
  eval "$(ssh-agent -s)"
  # Load ssh key automatically
  echo "Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
  # Add ssh key
  ssh-add -K ~/.ssh/id_rsa

  # GPG Keys
  ###########
  gpg --import $USBLOCATION/keys/gpg/public.asc
  gpg --import $USBLOCATION/keys/gpg/secret.asc

  # Set up git
  git config --global user.name "Bryce Thuilot"
  git config --global user.email bthuilot@gmail.com
  git config --global commit.gpgsign true
  git config --global user.signingkey $(gpg --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')
}

# Set up SSH and GPG Keys
# Set up git 
 read -r -p "Install keys from USB [Y/n]" response
 response=${response,,} # tolower
 if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    install_keys
 fi




######################
### Create folders ###
######################

GITHUB_FOLDER=~/github
BUILD_FOLDER=~/build
mkdir -p $GITHUB_HOLDER
mkdir -p $BUILD_FOLDER

# Install dot
DOT_REPO="git@github.com:bthuilot/dot.git"
DOT_DIR=$GITHUB_FOLDER/dot
git clone $DOT_REPO $DOT_DIR

cd $DOT_DIR

###########################
### Install XCode tools ###
###########################


# Install command line tools from xcode
xcode-select --install


########################
### Install Homebrew ###
########################

# Install Homebrew
if ! type "brew" > /dev/null; then
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Add fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

############################
### Install Applications ###
############################

# Command line packages
PACKAGES="git gpg neofetch neovim rbenv pandoc npm zsh wget"

# Graphical Applications
APPLICATIONS="firefox the-unarchiver gpg-suite deluge discord nordvpn slack daisydisk iterm2"

# Install packages using brew
brew install ${PACKAGES}
brew install ${APPLICATIONS}
# Not working for some reason -> need to look into more
brew install itsycal


#################
### ZSH Setup ###
#################

# Install Oh-my-zsh
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Set up zshrc
rm $HOME/.zshrc
ln zsh/mac.zshrc $HOME/.zshrc

## Zsh Theme
# Install Oxide (from github.com/dikiaap/dotfiles)
wget -O $HOME/.oh-my-zsh/custom/themes/oxide.zsh-theme https://raw.githubusercontent.com/dikiaap/dotfiles/master/.oh-my-zsh/themes/oxide.zsh-theme 

####################
### Install ruby ###
####################

eval "$(rbenv init -)"

RUBY_VERSION='2.7.0'
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv shell $RUBY_VERSION


##################
### Set up vim ###
##################

# Move config file
mkdir -p $HOME/.config/nvim/
ln vim/init.vim $HOME/.config/nvim/

# Set up vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set background
#BACKGROUND_IMAGE=Stars_at_night.png
#osascript -e 'tell application "System Events" to tell every desktop to set picture to "'$(pwd)'backgrounds/'${BACKGROUND_IMAGE}'"'


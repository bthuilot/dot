#!/bin/bash

###########################
### Install XCode tools ###
###########################

# Install command line tools from xcode
xcode-select --install


########################
### Install Homebrew ###
########################

# Install Homebrew
if ! type "$brew" > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Add cask
brew tap caskroom/cask
# Add fonts
brew tap caskroom/fonts

############################
### Install Applications ###
############################

# Command line packages
PACKAGES="git gpg neofetch neovim rbenv pandoc npm zsh wget"

# Graphical Applications
APPLICATIONS="iterm2 openemu minecraft visual-studio-code pinentry-mac firefox spotify spotmenu torbrowser balenaetcher the-unarchiver gpg-suite deluge discord nordvpn electrum slack font-fira-code daisydisk signal"

# Install packages using brew
brew install ${PACKAGES}
brew cask install ${APPLICATIONS}
# Not working for some reason -> need to look into more
brew cask install itsycal


#################
### ZSH Setup ###
#################


# Install zsh
if [ -d "/usr/local/bin/zsh" ]
then
  chsh -s /usr/local/bin/zsh
else
  chsh -s /bin/zsh
fi

# Install Oh-my-zsh
RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Set up zshrc
rm $HOME/.zshrc
ln zsh/mac.zshrc $HOME/.zshrc

## Zsh Theme
# Install Oxide (from github.com/dikiaap/dotfiles)
wget -O $HOME/.oh-my-zsh/custom/themes/oxide.zsh-theme https://raw.githubusercontent.com/dikiaap/dotfiles/master/.oh-my-zsh/themes/oxide.zsh-theme 

## Install ZSH Plugins
# Auto Suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

####################
### Install ruby ###
####################

eval "$(rbenv init -)"

RUBY_VERSION='2.5.0'
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

# Install neovim gem to use CommandT
gem install neovim


# Set up SSH and GPG Keys
# Set up git 
read -p "Do you want to install files from USB [Y/n]" -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  USBLOCATION=/Volumes/THUILOT/

  # Move SSH Key
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

  # Import GPG
  gpg --import $USBLOCATION/keys/gpg/public.asc
  gpg --import $USBLOCATION/keys/gpg/secret.asc

  # Set up git
  read -p "Set up git as Bryce? [Y/n]" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; 
  then
    git config --global user.name "Bryce Thuilot"
    git config --global user.email bthuilot@gmail.com
    git config --global commit.gpgsign true
    git config --global user.signingkey $(gpg --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')
  fi

fi

# Set dark mode 
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

# Set highlight color
osascript -e 'tell application "System Events" to tell apearance preferences to set highlight color to purple' 

# Set up github folder
mkdir -p ~/GitHub

# Set iTerm2 profile
## TODO ##


# Set background
BACKGROUND_IMAGE=Stars_at_night.png
osascript -e 'tell application "System Events" to tell every desktop to set picture to "'$(pwd)'backgrounds/'${BACKGROUND_IMAGE}'"'


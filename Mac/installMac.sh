#!/bin/bash

# Install Homebrew
if ! type "$brew" > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Add cask
brew tap caskroom/cask

# Install zsh
if [ -d "/bin/zsh"]
then
  chsh -s /bin/zsh
else
  brew install zsh
  chsh -s /bin/zsh
fi

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# The essentials

# Command line stuff
brew install git cowsay fortune gnupg chromedriver neovim rbenv npm

npm install -g spaceship-zsh-theme

cp files/zshrc ~/.zshrc

source .zshrc

rbenv install 2.4.2
rbenv global 2.4.2
rbenv shell 2.4.2

sudo gem install lolcat
sudo gem install sugarpaccione

# Applications
 brew cask install iterm2 atom google-chrome spotify pibakery etcher lastpass sonos the-unarchiver gpgtools bittorrent discord steam thunderbird


# Set up github folder
mkdir ~/GitHub

echo 'Authy still needs to be installed from chrome'
echo 'Files still need to be added from flash drive'
echo 'Please add your ssh key to GitHub'

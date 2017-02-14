#!/bin/bash

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
brew install git
brew install cowsay
brew install fortune
brew install gpg
gem install lolcat
gem install sugarpaccione

# Applications
brew cask install iterm2
brew cask install atom
brew cask install google-chrome
brew cask install spotify
brew cask install pibakery
brew cask install etcher
brew cask install lastpass
brew cask install sonos
brew cask install the-unarchiver
brew cask install flux
brew cask install vlc
brew cask install gpgtools
brew cask install paragon-ntfs


# Set up github folder
mkdir ~/GitHub

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
brew cask install iterm2 dropbox atom google-chrome spotify pibakery etcher lastpass the-unarchiver gpg-suite bittorrent discord steam thunderbird

gpg2 --import

# Set up github folder
mkdir ~/GitHub

#Set up git
git config --global user.name "Bryce Thuilot"
git config --global user.email bthuilot@gmail.com
git config --global commit.gpgsign true
git config --global gpg.program gpg2
git config --global user.signingkey $(gpg2 --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')


# Background

osascript -e ‘tell application “Finder” to set desktop picture to POSIX file “/path/to/picture.jpg”’

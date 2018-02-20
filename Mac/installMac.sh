#!/bin/bash

# Install Homebrew
if ! type "$brew" > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Add cask
brew tap caskroom/cask
# Add fonts
brew tap caskroom/fonts

# Install Applications
brew install git cowsay fortune gnupg chromedriver neovim rbenv npm zsh
brew cask install iterm2 dropbox atom google-chrome spotify etcher lastpass the-unarchiver gpg-suite deluge discord steam thunderbird font-fira-code


# Install zsh
if [ -d "/usr/local/bin/zsh"]
then
  chsh -s /usr/local/bin/zsh
else
  brew install zsh
  chsh -s /usr/local/bin/zsh
fi

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Set up fonts
cp ../Universal/KnackFont.ttf /Library/Fonts/

# Set up shell
cp terminal/zshrc ~/.zshrc
source ~/.zshrc

read -p "Do you want to install files from USB [Y/n]" installFromUSB
USBLOCATION=/Volumes/USB

if [[ installFromUSB -ne 'n' ]]; then
  # Move SSH
  mkdir -p ~/.ssh
  cp $USBLOCATION/Keys/SSH/id* ~/.ssh/
  ssh-add

  # Move GPG
  gpg2 --import $USBLOCATION/Keys/GPG/pub.asc
  gpg2 --import $USBLOCATION/Keys/GPG/sec.asc
fi


# Install ruby

RUBY_VERSION='2.5.0'
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv shell $RUBY_VERSION

gem install lolcat sugarpaccione


# Set up github folder
mkdir ~/GitHub

#Set up git
read -p "Set up git as Bryce? [Y/n]" setUpGit
if [[ setUpGit -ne 'n' ]]; then
  git config --global user.name "Bryce Thuilot"
  git config --global user.email bthuilot@gmail.com
  git config --global commit.gpgsign true
  git config --global gpg.program gpg2
  git config --global user.signingkey $(gpg2 --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')
fi

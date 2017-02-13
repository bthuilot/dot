#!/bin/bash


# Install zsh
if [ -d "/bin/zsh"]
then
  chsh -s /bin/zsh
else
  sudo apt-get install zsh
  chsh -s /bin/zsh
fi

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i -e 's/robbyrussell/agnoster/g' ~/.zshrc

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git
brew install lolcat
brew cask install iterm2
git clone 

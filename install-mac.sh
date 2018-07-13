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
PACKAGES="git cmatrix cowsay fortune gnupg neofetch chromedriver neovim rbenv pandoc npm zsh"

APPLICATIONS="iterm2 atom google-chrome spotify spotmenu torbrowser etcher lastpass the-unarchiver gpg-suite deluge discord steam nordvpn electrum slack font-fira-code istycal daisydisk helium"

brew install $PACKAGES
brew cask install $APPLICATIONS

# Install zsh
if [ -d "/usr/local/bin/zsh" ]
then
  chsh -s /usr/local/bin/zsh
else
  chsh -s /bin/zsh
fi


# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Set up fonts
cp ../fonts/* /Library/Fonts/

# Set up shell
cp zsh/zshrc ~/.zshrc
source ~/.zshrc

# Install space
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"

ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


## Set up neovim
# Move config file
mkdir -p ~/.config/nvim/
cp vim/init.vim ~/.config/nvim/
# Set up vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# Set up SSH and GPG Keys
# Set up git 
read -p "Do you want to install files from USB [Y/n]" installFromUSB
USBLOCATION="/Volumes/THUILOT/"

if [[ installFromUSB -ne 'n' ]]; then

  # Make ssh directory if not there
  mkdir -p ~/.ssh
  # Move SSH Key
  cp $USBLOCATION/keys/ssh/id* ~/.ssh/
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
  gpg2 --import $USBLOCATION/keys/gpg/pub.asc
  gpg2 --import $USBLOCATION/keys/gpg/sec.asc

  # Set up git
  read -p "Set up git as Bryce? [Y/n]" setUpGit
  if [[ setUpGit -ne 'n' ]]; then
    git config --global user.name "Bryce Thuilot"
    git config --global user.email bthuilot@gmail.com
    git config --global commit.gpgsign true
    git config --global gpg.program gpg2
    git config --global user.signingkey $(gpg2 --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')
  fi

fi
# Install ruby

RUBY_VERSION='2.5.0'
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv shell $RUBY_VERSION

gem install lolcat sugarpaccione

# Set dark mode 
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

# Set highlight color
osascript -e 'tell application "System Events" to tell apearance preferences to set highlight color to purple' 

# Set up github folder
mkdir -p ~/GitHub

# Set iTerm2 profile
if [ $(pwd) = "/Users/$USER/GitHub/dot" ]; then
    defaults read iTerm2/com.googlecode.iterm2.plist
else 
    git clone git@github.com:bthuilot/dot.git ~/GitHub/dot
    defaults read ~/GitHub/dot/iTerm2/com.googlecode.iterm2.plist
fi

# Move backgrounds to ~/Pictures
mkdir -p ~/Pictures/backgrounds/
cp backgrounds/* ~/Pictures/backgrounds

# Set backgound
BACKGOUND_IMAGE="Boston_Trippy.jpg"
osascript -e 'tell application "System Events" to tell every desktop to set picture to "~/Pictures/backgrounds/'$BACKGROUND_IMAGE'"' 

# Install coin bar
curl "https://github.com/adamwaite/CoinBar/releases/download/2.0/CoinBar.app.zip" >> /tmp/CoinBar.app.zip
unzip /tmp/CoinBar.app.zip -d /Applications

# Install command line tools from xcode
xcode-select --install



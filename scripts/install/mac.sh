#!/bin/bash
#
# macOS install guide for https://github.com/bthuilot/dot
# (C) Bryce Thuilot 2022 <bryce@thuilot.io>
# License: GPL v3

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;32m'
NO_COLOR='\033[0m'

#######################################
# Ensures the backup USB is present
# and sets it to an ENV variable. Exits
# with code 1 if directory doesn't exist
# Globals:
#   USBLOCATION
# Arguments:
#   None
# Output:
#   Writes error message to STDERR
#   if backup USB is not present
#######################################
function check_for_usb {
    USBLOCATION=/Volumes/BACKUP/
    if [ ! -d $USBLOCATION ]; then
	>&2 echo -e "${RED}ERROR:${NO_COLOR} USB not found, exiting" && exit 1
    fi
}

#######################################
# Installs public & secret keys from
# backup USB and sets GPG_KEY_SET ENV
# variable if installation was
# successfull. Will exit if backup USB
# is not present.
# Globals:
#   USBLOCATION
#   GPG_KEY_SET
#   HOME
# Arguments:
#   None
# Output:
#   Writes status to STDOUT and any
#   output from `gpg` command
#######################################
function install_gpg_key {
    check_for_usb
    echo -n  "Installing GPG keys..."
    # Setup GPG agent config
    mkdir -p ~/.gnupg/
    echo "pinentry-program /usr/local/bin/pinentry-mac" >> $HOME/.gnupg/gpg-agent.conf
    gpg-connect-agent reloadagent /bye 1> /dev/null

    # Import keys
    gpg --no_tty --import $USBLOCATION/keys/gpg/public.asc
    gpg --no_tty --import $USBLOCATION/keys/gpg/secret.asc
    echo -e "${GREEN}done${NO_COLOR}"
    GPG_KEY_SET=1
}

#######################################
# Unzips backgrounds zip file from
# backup USB to the dot repo directory.
# Does nothing is background USB is
# not present
# Globals:
#   USBLOCATION
#   BACKGROUND_ZIP
# Arguments:
#   None
# Output:
#   Writes status messages to STDOUT.
#######################################
function setup_backgrounds {
    echo -n "Unzipping background folder... "
    BACKGROUND_ZIP=$USBLOCATION/backgrounds.zip
    if [ ! -f $BACKGROUND_ZIP ]; then
	echo -e "${RED}zip file not found, skipping${NO_COLOR}"
    else
	unzip $BACKGROUND_ZIP -d $DOT_DIR/backgrounds 1> /dev/null && echo -e "${GREEN}done${NO_COLOR}"
    fi
}

#######################################
# Creats an SSH Key using `ssh-keygen`,
# starts ssh-agent an enables the key
# to be autoloaded by the agent
# Globals:
#   HOME
# Arguments:
#   None
#######################################
function create_ssh_key {
    echo "Setting up SSH config..."
    # Generate SSH key
    ssh-keygen -t ed25519 -C "bryce@thuilot.io" -N "" -f ~/.ssh/id_ed25519 1> /dev/null
    
    # Start the ssh-agent in the background
    eval "$(ssh-agent -s)" 1> /dev/null

    # Load ssh key automatically
    echo "Host *\n AddKeysToAgent yes\nUseKeychain yes\nIdentityFile ~/.ssh/id_ed25519" > $HOME/.ssh/config

    # Add SSH key to SSH agent
    ssh-add -K $HOME/.ssh/id_ed25519 1> /dev/null
    
    cat $HOME/.ssh/id_ed25519 | pbcopy
    echo "Public key copied to keyboard, please add to GitHub before continuing"
    read # Read to wait till enter is pressed
    echo -e "${GREEN}done${NO_COLOR}"
}

#######################################
# Sets up git config with name, email
# gpgsign set to true, and which GPG key
# to use if GPG_KEY_SET is set
# Globals:
#   GPG_KEY_SEY
# Arugments:
#   None
# Output:
#   None
#######################################
function setup_git {
    echo -n "Setting up git config... "
    # Set up git
    git config --global user.name "Bryce Thuilot"
    git config --global user.email bryce@thuilot.io
    git config --global commit.gpgsign true
    
    if [[ -z "${GPG_KEY_SET}" ]]; then
	git config --global user.signingkey $(gpg --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}') 
    fi
    echo -e "${GREEN}done${NO_COLOR}"
}

#######################################
# Create filesystem layout. Creates
# ~/github and ~/build directories
# and clones the dot repo. sets the
# directories into env variables for
# use in this script
# Globals:
#   HOME
#   GITHUB_FOLDER
#   BUILD_FOLDER
#   DOT_REPO_URL
#   DOT_DIR
# Arguments:
#   None
#######################################
function create_fs_layout {
    GITHUB_FOLDER=$HOME/github
    BUILD_FOLDER=$HOME/build
    mkdir -p $GITHUB_HOLDER
    mkdir -p $BUILD_FOLDER

    # Install dot
    DOT_REPO_URL="git@github.com:bthuilot/dot.git"
    DOT_DIR=$GITHUB_FOLDER/dot
    git clone $DOT_REPO_URL $DOT_DIR &> /dev/null
}



#######################################
# Installs packages via brew
# Arguments:
#   None
#######################################
function install_packages {
    echo "Installing packages from homebrew... "
    
    # Install Homebrew
    if ! type "brew" > /dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi


    # Command line packages
    cli_apps="git gpg neofetch neovim rbenv pandoc npm zsh wget"

    # Graphical Applications
    gui_apps="firefox the-unarchiver gpg-suite deluge discord slack daisydisk iterm2 emacs pinentry-mac"

    # Install packages using brew
    brew install ${cli_apps}
    brew install --cask ${gui_apps}
    # Not working for some reason -> need to look into more
    brew install itsycal

    # Add fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-fira-code

    echo -e "${GREEN}done${NO_COLOR}"
}

#######################################
# Installs ZSH and links ZSH config
# file and sets theme
# Globals:
#   DOT_DIR
#   HOME
#   RUNZSH
# Arguments:
#   None
#######################################
function install_zsh {
    echo "Installing ZSH... "
    # Install Oh-my-zsh
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Set up zshrc
    rm $HOME/.zshrc
    ln $DOT_DIR/zsh/mac.zshrc $HOME/.zshrc

    ## Zsh Theme
    # Install Oxide (from github.com/dikiaap/dotfiles)
    wget -O $HOME/.oh-my-zsh/custom/themes/oxide.zsh-theme https://raw.githubusercontent.com/dikiaap/dotfiles/master/.oh-my-zsh/themes/oxide.zsh-theme > /dev/null

    echo -e "${GREEN}done${NO_COLOR}"
}

#######################################
# Links emacs config files to emacs
# config directory
# Globals:
#   DOT_DIR
#   HOME
# Arugemnts:
#   None
#######################################
function setup_emacs {
    echo -n "Setting up emacs... "
    # Set up config directories
    rm -r $HOME/.emacs.d/

    # Link config files
    ln -s $DOT_DIR/emacs  $HOME/.emacs.d/
    echo -e "${GREEN}done${NOCOLOR}"
}


######################################
# Disable natural scroll direction
# Globals:
#   None
# Arguments:
#   None
######################################
function disable_natural_scroll {
    osascript <<'END'
try
	tell application "System Preferences"
		activate
		set current pane to pane "com.apple.preference.trackpad"
	end tell
	delay 2
	tell application "System Events"
		tell process "System Preferences"
			click radio button "Scroll & Zoom" of tab group 1 of window "Trackpad"
			set scrollDirection to checkbox 1 of tab group 1 of window "Trackpad"
			tell scrollDirection
				if (its value as boolean) then click scrollDirection
			end tell
			tell application "System Preferences" to quit
		end tell
	end tell
end try
END

}



####################
### Entry Point  ###
####################


# Install command line tools from xcode
xcode-select --install

# Wait until XCode Command Line Tools installation has finished.
until $(xcode-select --print-path &> /dev/null); do
  sleep 5;
done

# Install `brew` packages
install_packages


# Key Setup #
# --------- #

# Install GPG key
read -p "Install GPG key from USB? [Y/n]" yn
case $yn in 
    [Nn]* ) echo "Skipping";;
    * ) install_gpg_key;;
esac

# Create SSH Key
create_ssh_key

# Personalization #
# --------------- #

# Setup up git with name, email 
setup_git

# Create file system layout
create_fs_layout

# Setup ZSH
install_zsh

# Setup Emacs
setup_emacs

# Set scroll directory
disable_natural_scroll

# Set downloads folder
# TODO

# Set dock
# TODO

# Set background
BACKGROUND_IMAGE=NewYorkAbove.jpg
osascript -e 'tell application "System Events" to tell every desktop to set picture to "'$DOT_DIR'/backgrounds/'${BACKGROUND_IMAGE}'"'


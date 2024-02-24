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

# Secret values
OP_GPG_PRIVATE_KEY='op://dev/gpg-key/private-key'
OP_GPG_PUBLIC_KEY='op://dev/gpg-key/public-key'

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
    echo -n  "Installing GPG keys..."
    # Setup GPG agent config
    mkdir -p ~/.gnupg/
    echo "pinentry-program /usr/local/bin/pinentry-mac" >> $HOME/.gnupg/gpg-agent.conf
    gpg-connect-agent reloadagent /bye 1> /dev/null

    # Import keys
    op read "$OP_GPG_PUBLIC_KEY" |  gpg --no_tty --import
    op read "$OP_GPG_PRIVATE_KEY" |  gpg --no_tty --import-secret-key
    echo -e "${GREEN}done${NO_COLOR}"
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
    PUB_KEY="$HOME/.ssh/id_ed25519.pub"
    PRIV_KEY="$HOME/.ssh/id_ed25519"
    ssh-keygen -t ed25519 -C "bryce@thuilot.io" -N "" -f "$PRIV_KEY" 1> /dev/null

    # Start the ssh-agent in the background
    eval "$(ssh-agent -s)" 1> /dev/null

    # Load ssh key automatically
    printf "Host *\n AddKeysToAgent yes\nUseKeychain yes\nIdentityFile %s\n" "$PRIV_KEY" > $HOME/.ssh/config

    # Add SSH key to SSH agent
    ssh-add -K "$PRIV_KEY" 1> /dev/null
    echo -e "${GREEN}done${NO_COLOR}"
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
      echo "homebrew not found, skipping package installation"
      return
    fi


    # Command line packages
    cli_apps="git gpg neofetch pandoc npm zsh wget gh"

    # Graphical Applications
    gui_apps="firefox the-unarchiver gpg-suite deluge discord slack daisydisk iterm2 pinentry-mac"

    # Install packages using brew
    # shellcheck disable=SC2086
    brew install ${cli_apps}
    # shellcheck disable=SC2086
    brew install --cask ${gui_apps}
    # Not working for some reason -> need to look into more
    # brew install itsycal

    # Add fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-fira-code

    echo -e "${GREEN}done${NO_COLOR}"
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

prompt_for_cmd() {
    read -p "${1} [Y/n]: " yn
    case $yn in
	[nN] ) echo "skipping";;
	* ) ${2};;
    esac

}


#######################################
# Entry point of the install script
# Globals:
# Outputs:
#   Writes status to STDOUT
# Arguments:
#   None
#######################################
main() {
    prompt_for_cmd "install homebrew packages?" install_packages
    prompt_for_cmd "setup GPG key?" install_gpg_key
    prompt_for_cmd "generate new SSH key?" create_ssh_key
    prompt_for_cmd "setup git?"  "$DOT_DIR/scripts/install/git.sh macos"
    prompt_for_cmd "setup emacs?" "$DOT_DIR/scripts/install/emacs.sh macos"
    prompt_for_cmd "setup ZSH?" "$DOT_DIR/scripts/install/zsh.sh macos"
}


cat << 'EOF'

###################################
     _       _    __ _ _
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/

              -------
              Install
              -------

###################################

https://github.com/bthuilot/dot

press enter to continue...
EOF

read # wait for enter
main


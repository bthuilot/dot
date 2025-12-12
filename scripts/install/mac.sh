#!/bin/bash
# Copyright (C) 2017-2025 Bryce Thuilot <bryce@thuilot.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the FSF, either version 3 of the License, or (at your option) any later version.
# See the LICENSE file in the root of this repository for full license text or
# visit: <https://www.gnu.org/licenses/gpl-3.0.html>.

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;32m'
NO_COLOR='\033[0m'

# Secret values
OP_GPG_PRIVATE_KEY='op://dev/gpg-key/private-key'
OP_GPG_PUBLIC_KEY='op://dev/gpg-key/public-key'

# Dot directory
DIR="$(dirname -- "${BASH_SOURCE[0]}")"
DOT_DIR="$(realpath -- "$DIR/../..")"

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
	echo -n "Installing GPG keys..."
	# Setup GPG agent config
	mkdir -p ~/.gnupg/
	echo "pinentry-program /usr/local/bin/pinentry-mac" >>$HOME/.gnupg/gpg-agent.conf
	gpg-connect-agent reloadagent /bye 1>/dev/null

	# Import keys
	op read "$OP_GPG_PUBLIC_KEY" | gpg --no_tty --import
	op read "$OP_GPG_PRIVATE_KEY" | gpg --no_tty --import-secret-key
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
	if ! type "brew" >/dev/null; then
		echo "homebrew not found, skipping package installation"
		return
	fi

	# Command line packages
	cli_apps="git gnupg zsh wget gh kubectl kubectx jq"

	# Graphical Applications
	gui_apps="firefox 1password 1password-cli gpg-suite iterm2 pinentry-mac"

	# Install packages using brew
	# shellcheck disable=SC2086
	brew install ${cli_apps}
	# shellcheck disable=SC2086
	brew install --cask ${gui_apps}
	# Not working for some reason -> need to look into more

	# Add fonts
	brew install --cask font-fira-code font-fira-code-nerd font-fira-code-mono-nerd

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
		tell process "System Preferences"`
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
	[nN]) echo "skipping" ;;
	*) ${2} ;;
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
	prompt_for_cmd "setup git?" "$DOT_DIR/scripts/install/git.sh macos"
	prompt_for_cmd "setup emacs?" "$DOT_DIR/scripts/install/emacs.sh macos"
	prompt_for_cmd "setup ZSH?" "$DOT_DIR/scripts/install/zsh.sh macos"
}

cat <<'EOF'

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

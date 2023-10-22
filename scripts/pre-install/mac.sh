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
# Install XCode command line tools
# Globals:
#   None
# Arguments:
#   None
# Output:
#   Writes status to STDOUT
#######################################
function install_xcode {
    echo -n "Installing XCode command line tools..."
    xcode-select --install 1> /dev/null
    # Wait until XCode Command Line Tools installation has finished.
    # shellcheck disable=SC2091
    until $(xcode-select --print-path &> /dev/null); do
      sleep 5;
    done

    echo -e "${GREEN}done${NO_COLOR}"
}


#######################################
# Install Homebrew
# Globals:
#   None
# Arguments:
#   None
# Output:
#   Writes status to STDOUT
#######################################
function install_homebrew {
    echo -n "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 1> /dev/null
    echo -e "${GREEN}done${NO_COLOR}"
}

#######################################
# Install Homebrew packages
# Globals:
#   None
# Arguments:
#   List of packages to install
# Output:
#   Writes status to STDOUT
#######################################
function install_homebrew_packages() {
    echo -n "Installing Homebrew packages \"${*@}\" ..."
    # shellcheck disable=SC2068
    brew install ${@}
    echo -e "${GREEN}done${NO_COLOR}"
}


echo "##########################"
echo "## dotfiles - preinstall ##"
echo "##########################"
echo ""
install_xcode
echo ""
install_homebrew_packages "homebrew/cask/1password" "homebrew/cask/1password-cli" "homebrew/casks/emacs"
echo ""
echo -e "${GREEN}install complete${NO_COLOR}"
#!/bin/bash
#
# macOS install guide for https://github.com/bthuilot/dot
# (C) Bryce Thuilot 2023 <bryce@thuilot.io>
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
install_xcode() {
    echo -n "Installing XCode command line tools..."
    xcode-select --install &> /dev/null
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
install_homebrew() {
    echo -n "Installing Homebrew..."
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 1> /dev/null
    fi
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
install_homebrew_packages() {
    echo -n "Installing Homebrew packages \"${@}\" ..."
    # shellcheck disable=SC2068
    brew install ${@} &> /dev/null
    echo -e "${GREEN}done${NO_COLOR}"
}

prompt_for_cmd() {
  prompt="$1"
  cmd="$2"
  read -r -p "${prompt} [Y/n]: " yn
  shift 2
  case $yn in
    [nN] ) echo "skipping";;
	  *)
	    # shellcheck disable=SC2068
	    ${cmd} ${@}; echo '';;
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
    prompt_for_cmd "install xcode?" install_xcode
    prompt_for_cmd "install homebrew?" install_homebrew
    prompt_for_cmd "install 1password?" install_homebrew_packages "homebrew/cask/1password" "homebrew/cask/1password-cli"
    prompt_for_cmd "install emacs?" install_homebrew_packages "homebrew/casks/emacs"
    echo -e "${GREEN}install complete${NO_COLOR}"
}


cat << 'EOF'

###################################
     _       _    __ _ _
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/

            -----------
            Pre Install
            -----------

###################################

https://github.com/bthuilot/dot

press enter to continue...
EOF

read

main

echo "${GREEN}done{NO_COLOR}"

cat <<EOF

install complete, please the following after configuring
1password and the SSH agent for github:

cd $HOME/github && git clone git@github.com:bthuilot/dot.git && cd dot && make install-mac

EOF
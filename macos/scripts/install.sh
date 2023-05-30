#!/usr/bin/env bash
#
# macOS install guide for https://github.com/bthuilot/dot
# (C) Bryce Thuilot 2022 <bryce@thuilot.io>
# License: GPL v3

# # Colors
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;32m'
export NO_COLOR='\033[0m'



#######################################
# Prints a message to STDERR prefixed
# with error, and exits the program
# Arugments:
#   A error message to print
# Outputs:
#  STDERR
#######################################
err() {
    >&2 echo -e "${RED}error${NO_COLOR}: ${1}" && exit 1
}


#######################################
# Prints a message to STDOUT in success
# (green) text
# Arugments:
#   A message to print
# Outputs:
#  STDOUT
#######################################
success_msg() {
    echo -e "${GREEN}${1}${NO_COLOR}"
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
create_fs_layout() {
    export GITHUB_FOLDER="${HOME}/github"
    export BUILD_FOLDER="${HOME}/build"
    mkdir -p "${GITHUB_FOLDER}"
    mkdir -p "${BUILD_FOLDER}"

    # Install dot
    DOT_REPO_URL="git@github.com:bthuilot/dot.git"
    DOT_DIR="${GITHUB_FOLDER}/dot"
    [ ! -d "$DOT_DIR" ] && git clone "$DOT_REPO_URL" "$DOT_DIR" &> /dev/null
}


#######################################
# Configures Git and Authenticates
# GitHub CLI tool
# Globals:
#   GPG_KEY_SET
# Argumnets:
#  None
#######################################
configure_git() {
    # Set up git
    git config --global user.name "Bryce Thuilot"
    git config --global user.email bryce@thuilot.io
    git config --global commit.gpgsign true
    
    if [[ -z "${GPG_KEY_SET}" ]]; then
	git config --global user.signingkey $(gpg --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}') 
    fi

    echo "authenticating with GitHub CLI..."
    gh auth login

    success_msg "done"
}

#######################################
# Generates an SSH Key using ssh-keygen and
# starts ssh-agent an enables the key
# to be autoloaded by the agent
# Globals:
#   HOME
#   DOT_SSH_KEY
# Arguments:
#   None
#######################################
generate_ssh_key() {
    echo "generating a new SSH key..."
    # Generate SSH key

    export PRIV_SSH_KEY="${HOME}/.ssh/id_ed25519"
    export PUB_SSH_KEY="${HOME}/.ssh/id_ed25519.pub"
    ssh-keygen -t ed25519 -C "bryce@thuilot.io" -N "" -f ~/.ssh/id_ed25519 1> /dev/null
    
    # Start the ssh-agent in the background
    eval "$(ssh-agent -s)" 1> /dev/null

    # Load ssh key automatically
    echo -e "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ${PRIV_SSH_KEY}" > $HOME/.ssh/config

    # Add SSH key to SSH agent
    ssh-add -K $HOME/.ssh/id_ed25519 1> /dev/null

    success_msg "done"
}


#######################################
# Installs packages via brew
# Arguments:
#   None
# Outputs:
#   Writes status to STDOUT & STDERR
#######################################
install_packages() {
    echo "checking for hombrew..."
    
    # Install Homebrew
    if ! type "brew" > /dev/null; then
	echo "brew command not found, installing"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    success_msg "done"

    echo "installing packages via hombrew..."

    # Command line packages
    declare -a cli_apps=(git gpg neofetch rbenv npm zsh wget gh)

    # Graphical Applications
    declare -a gui_apps=(firefox gpg-suite deluge discord slack daisydisk iterm2 emacs pinentry-mac itsycal 1password 1password-cli)

    # Install packages using brew
    brew install ${cli_apps[@]}
    brew install --cask ${gui_apps[@]}

    # Add fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-fira-code

    success_msg "done"
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
    prompt_for_cmd "install homebrew & packages?" install_packges
    prompt_for_cmd "generate new SSH key?" generate_ssh_key
    prompt_for_cmd "setup GitHub CLI?"  auth_github
    prompt_for_cmd "create filesystem layout?" create_fs_layout
    
}


cat << 'EOF'

###################################
     _       _    __ _ _           
  __| | ___ | |_ / _(_) | ___  ___ 
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/

###################################                                   

https://github.com/bthuilot/dot

press enter to continue...
EOF

read # wait for enter
main


#!/bin/bash
#
# macOS emacs installation script for https://github.com/bthuilot/dot
# (C) Bryce Thuilot 2024 <bryce@thuilot.io>
# License: GPL v3
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;32m'
NO_COLOR='\033[0m'

echo "Setting up git ..."
# Set up git
git config --global user.name "Bryce Thuilot"
git config --global user.email "bryce@thuilot.io"
git config --global commit.gpgsign true
git config --global core.editor "emacs -nw"
git config --global init.defaultBranch main
git config --global user.signingkey "$(gpg --list-secret-keys --keyid-format LONG | grep -B 2 ultimate | grep sec  |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')"

echo -e "${GREEN}done${NO_COLOR}"
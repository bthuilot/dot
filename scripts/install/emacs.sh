#!/bin/bash
#
# macOS emacs installation script for https://github.com/bthuilot/dot
# (C) Bryce Thuilot 2024 <bryce@thuilot.io>
# License: GPL v3

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;32m'
NO_COLOR='\033[0m'

OS="$1"

echo "Setting up emacs for $OS ..."
# check if existing .emacs.d/init.el file exists
if [ -f "$HOME/.emacs.d/init.el" ]; then
    echo -e "${YELLOW}~/.emacs.d/.init.el already exists:${NO_COLOR} backing up existing config"
    mv "$HOME/.emacs.d/init.el" "$HOME/.emacs.d/init.backup.el"
fi

# Set up config directories
mkdir -p "$HOME/.emacs.d"

# Link config files
ln -s "$DOT_DIR/configs/$OS.init.el" "$HOME/.emacs.d/init.el"

echo -e "${GREEN}done${NO_COLOR}"
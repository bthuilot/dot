#!/bin/bash
#
# macOS zsh installation script for https://github.com/bthuilot/dot
# (C) Bryce Thuilot 2024 <bryce@thuilot.io>
# License: GPL v3

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;32m'
NO_COLOR='\033[0m'

OS="$1"


echo "Installing ZSH for $OS ..."
# Install Oh-my-zsh
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Set up zshrc
rm "$HOME/.zshrc"
ln -s "$DOT_DIR/configs/$OS.zshrc" "$HOME/.zshrc"

## Zsh Theme
# Install Oxide (from github.com/dikiaap/dotfiles)
curl -L https://raw.githubusercontent.com/dikiaap/dotfiles/master/.oh-my-zsh/themes/oxide.zsh-theme > "$HOME/.oh-my-zsh/custom/themes/oxide.zsh-theme"

echo -e "${GREEN}done${NO_COLOR}"
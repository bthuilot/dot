#!/bin/bash
#
# macOS zsh installation script for https://github.com/bthuilot/dot
# (C) Bryce Thuilot 2024 <bryce@thuilot.io>
# License: GPL v3
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

# Dot directory
DIR="$( dirname -- "${BASH_SOURCE[0]}"; )";
DOT_DIR="$( realpath -- "$DIR/../.."; )";

echo "Installing ZSH..."
if test -d "$HOME/.oh-my-zsh"; then
  echo -e "${YELLOW}SKIP:${NO_COLOR}Oh-my-zsh is already installed"
else
  # Install Oh-my-zsh
  export RUNZSH="no"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo "${GREEN}done${NO_COLOR}"
fi

##################
# zshrc Template #
##################
# eval template
TEMPLATED=$(go run "$DOT_DIR/scripts/templater/main.go" -in "$DOT_DIR/templates/zshrc.tmpl" "DOT_DIR=$DOT_DIR")

# remove existing template
sed -i.pre-dot-files '/# BEGIN BTHUILOT\/DOT TEMPLATE/,/# END BTHUILOT\/DOT TEMPLATE/d' "$HOME/.zshrc"
# Write to file
echo "
# BEGIN BTHUILOT/DOT TEMPLATE
$TEMPLATED
# END BTHUILOT/DOT TEMPLATE
" >> "$HOME/.zshrc"

# Zsh Theme
CUSTOM_THEME_FILE="$HOME/.oh-my-zsh/custom/themes/oxide.zsh-theme"
if [[ -f "$CUSTOM_THEME_FILE" ]]; then
    echo -e "${YELLOW}Skipping zsh theme installation${NO_COLOR}"
else
    # Install Oxide (from github.com/dikiaap/dotfiles)
    curl -L https://raw.githubusercontent.com/dikiaap/dotfiles/master/.oh-my-zsh/themes/oxide.zsh-theme > "$CUSTOM_THEME_FILE"
fi


echo -e "${GREEN}done${NO_COLOR}"
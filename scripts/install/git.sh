#!/usr/bin/env zsh
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
git config --global user.signingkey "$(gpg --list-secret-keys --keyid-format LONG | grep -B 2 ultimate | grep sec  |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')"


######################
# gitconfig Template #

######################
# eval template
TEMPLATED=$(go run "$DOT_DIR/scripts/templater/main.go" -in "$DOT_DIR/templates/gitconfig.tmpl" "DOT_DIR=$DOT_DIR")

# remove existing template
sed -i.pre-dot-files '/# BEGIN BTHUILOT\/DOT TEMPLATE/,/# END BTHUILOT\/DOT TEMPLATE/d' "$HOME/.gitconfig"
# Write to file
echo "
# BEGIN BTHUILOT/DOT TEMPLATE
$TEMPLATED
# END BTHUILOT/DOT TEMPLATE
" >> "$HOME/.gitconfig"



echo -e "${GREEN}done${NO_COLOR}"
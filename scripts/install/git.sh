#!/usr/bin/env zsh
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

echo "Setting up git ..."
# Set up git
git config --global user.signingkey "$(gpg --list-secret-keys --keyid-format LONG | grep -B 2 ultimate | grep sec | awk -F'/' '{print $2}' | awk -F' ' '{print $1}')"

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
" >>"$HOME/.gitconfig"

echo -e "${GREEN}done${NO_COLOR}"

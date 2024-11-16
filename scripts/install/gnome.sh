#!/bin/bash
#
# Gnome installation/configuration script for https://github.com/bthuilot/dot
# (C) Bryce Thuilot 2024 <bryce@thuilot.io>
# License: GPL v3
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;32m'
NO_COLOR='\033[0m'

echo "Setting up gnome ..."
if ! command -v gsettings &> /dev/null; then
    echo "please install gnome tweak tool"
    exit 1
fi


# gsettings reset org.gnome.mutter overlay-key
# gesttings set org.gnome.shell.keybindings toggle-overview "['<Control>Space']"
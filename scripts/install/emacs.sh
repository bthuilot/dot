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

echo "Setting up emacs ..."

mkdir -p "$HOME/.emacs.d"

# check if existing .emacs.d/init.el file exists
if [ ! -f "$HOME/.emacs.d/init.el" ]; then
    echo -e "${YELLOW}no emacs config exists${NO_COLOR}: creating base config"
    cat <<EOF > "$HOME/.emacs.d/init.el"
    ;;; init.el --- emacs config file -*- lexical-binding: t; -*-

    ;; Copyright (C) Bryce Thuilot 2024


    ;; Author: Bryce Thuilot <bryce@thuilot.io>
    ;; Created: $(date '+%d %b %Y')

    ;; URL: https://github.com/bthuilot/dot

    ;;; Commentary:
    ;; 'init.el' Emacs config file.
    ;; Used to load in other Emacs config files

    ;;; Code:


    (provide 'init)
    ;;; init.el ends here
EOF
fi

##################
# init.el Template #
##################

# eval template
TEMPLATED="$(go run "$DOT_DIR/scripts/templater/main.go" -in "$DOT_DIR/templates/init.el.tmpl" "DOT_DIR=$DOT_DIR")"

# remove existing template
sed -i.pre-dot-files '/;; BEGIN BTHUILOT\/DOT TEMPLATE/,/;; END BTHUILOT\/DOT TEMPLATE/d' "$HOME/.emacs.d/init.el"
# WRite template above provide line
sed -i.no-dot-files-template "s|^(provide 'init)|;; BEGIN BTHUILOT/DOT TEMPLATE\n${TEMPLATED//$'\n'/\\n}\n;; END BTHUILOT/DOT TEMPLATE\n\n(provide 'init)|" "$HOME/.emacs.d/init.el"

echo -e "${GREEN}done${NO_COLOR}"
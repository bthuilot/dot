#!/bin/bash
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

echo "Setting up emacs ..."

mkdir -p "$HOME/.emacs.d"

# check if existing .emacs.d/init.el file exists
if [ ! -f "$HOME/.emacs.d/init.el" ]; then
	echo -e "${YELLOW}no emacs config exists${NO_COLOR}: creating base config"
	cat <<EOF >"$HOME/.emacs.d/init.el"
;;; init.el --- emacs config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot <bryce@thuilot.io> 2017-2025


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

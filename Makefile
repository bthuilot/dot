# Copyright (C) 2017-2025 Bryce Thuilot <bryce@thuilot.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the FSF, either version 3 of the License, or (at your option) any later version.
# See the LICENSE file in the root of this repository for full license text or
# visit: <https://www.gnu.org/licenses/gpl-3.0.html>.

OS := $(shell uname)
DOT_DIR := $(shell pwd)

.PHONY: install-mac install-linux
install-mac:
	@./scripts/install/mac.sh

install-linux:
	@./scripts/install/linux.sh

install-zsh:
	@./scripts/install/zsh.sh

install-emacs:
	@./scripts/install/emacs.sh

install-git:
	@./scripts/install/git.sh


template-zshrc:
	@go run ./scripts/templater/main.go -in ./templates/zshrc.tmpl OS=$(OS) DOT_DIR=$(DOT_DIR)


template-init-el:
	@go run ./scripts/templater/main.go -in ./templates/init.el.tmpl OS=$(OS) DOT_DIR=$(DOT_DIR)

fmt-license:
	license-eye header fix

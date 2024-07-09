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
	@go run ./scripts/helpers/templater/main.go -in ./templates/zshrc.tmpl OS=$(OS) DOT_DIR=$(DOT_DIR)


template-init-el:
	@go run ./scripts/helpers/templater/main.go -in ./templates/init.el.tmpl OS=$(OS) DOT_DIR=$(DOT_DIR)

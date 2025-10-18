#!/bin/zsh
# Copyright (C) 2017-2025 Bryce Thuilot <bryce@thuilot.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the FSF, either version 3 of the License, or (at your option) any later version.
# See the LICENSE file in the root of this repository for full license text or
# visit: <https://www.gnu.org/licenses/gpl-3.0.html>.


############
# Env Vars #
############

if [ -z "$DOT_DIR" ]; then
	export DOT_DIR="$HOME/github/dot"
fi

if [ -z "$GITHUB_USER" ]; then
	export GITHUB_USER="bthuilot"
fi

export LESS="-F $LESS"
export EDITOR='tem'
export SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

# PATH exports
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:$GOPATH/bin:$GOBIN"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# OS specific
if [[ $(uname) == "Darwin" ]]; then
    export XDG_DATA_HOME="$HOME/Library"
    export XDG_CONFIG_HOME="$HOME/Library/Preferences"
    export XDG_CACHE_HOME="$HOME/Library/Caches"
    export GOROOT="$(brew --prefix golang)/libexec"
    export TERM=rxvt-256color
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
else
    export GOROOT="/usr/local/go"
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nv
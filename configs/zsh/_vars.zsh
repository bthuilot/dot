#!/bin/zsh

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
export XDG_DATA_HOME="$HOME/Library"
export XDG_CONFIG_HOME="$HOME/Library/Preferences"
export XDG_CACHE_HOME="$HOME/Library/Caches"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nv


# PATH exports
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# OS specific
if [[ $(uname) == "Darwin" ]]; then
  export GOROOT="$(brew --prefix golang)/libexec"
  export TERM=rxvt-256color
  export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
else
  export GOROOT="/usr/local/go"
fi



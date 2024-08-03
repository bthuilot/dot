#!/bin/zsh

############
# Env Vars #
############

if [ -z "$DOT_DIR" ]; then
  export DOT_DIR="$HOME/github/dot"
fi

export LESS="-F $LESS"
export EDITOR='tem'
export SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export NVM_DIR="$HOME/.nvm"

# PATH exports
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"
export PATH="/usr/local/sbin:$PATH"

# OS specific
if [[ $(uname) == "Darwin" ]]; then
  export GOROOT="$(brew --prefix golang)/libexec"
  export TERM=rxvt-256color
  export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
else
  export GOROOT="/usr/local/go"
fi
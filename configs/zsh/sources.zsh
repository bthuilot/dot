#!/bin/zsh

###########
# Sources #
###########

# Source Opam
[[ ! -r /Users/bryce/.opam/opam-init/init.zsh ]] || source /Users/bryce/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Source GHCup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Load NVM
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

#########
# Eval #
########

# rbenv
command -v rbenv > /dev/null && eval "$(rbenv init -)"
# pyenv
command -v pyenv > /dev/null && eval "$(pyenv init -)"

#!/usr/bin/env zsh

###########
# Sources #
###########

# Source Opam
[[ ! -r /Users/bryce/.opam/opam-init/init.zsh ]] || source /Users/bryce/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Source GHCup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Load NVM
export NVM_DIR="$HOME/Library/Preferences/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#########
# Eval #
########

# rbenv
command -v rbenv > /dev/null && eval "$(rbenv init -)"
# pyenv
command -v pyenv > /dev/null && eval "$(pyenv init -)"

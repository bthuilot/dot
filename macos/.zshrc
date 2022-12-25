# Load plugins
plugins=(
  git
)

## Themes
ZSH_THEME='oxide'


###########
# Exports #
###########

export TERM=rxvt-256color
export ZSH=$HOME/.oh-my-zsh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOROOT="$(brew --prefix golang)/libexec"
export NVM_DIR="$HOME/.nvm"

# PATH exports
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"


###################
# Sources & Evals #
###################

# Source Opam
[[ ! -r /Users/bryce/.opam/opam-init/init.zsh ]] || source /Users/bryce/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Source Oh My ZSH
source $ZSH/oh-my-zsh.sh

# Source GHCup
[ -f "/Users/bryce/.ghcup/env" ] && source "/Users/bryce/.ghcup/env"

# Load rbenv
eval "$(rbenv init -)"

# Load NVM
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

#########
# Alias #
#########

alias ip='ifconfig | grep "inet " | awk "NR == 2" | cut -f2 -d" "'
alias suroot='sudo -E -s'
alias convertm4as='for foo in *.m4a; do ffmpeg -i "$foo" -acodec libmp3lame -aq 2 "${foo%.m4a}.mp3"; done'
alias reload="source $HOME/.zshrc"


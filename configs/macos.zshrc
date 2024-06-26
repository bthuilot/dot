# -*- shell-script -*-

# Load plugins
plugins=(
    git
    macos
)

###########
# Exports #
###########

export TERM=rxvt-256color
export DOT_DIR="$HOME/github/dot"
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


# ZSH Config #
ZSH_THEME='oxide'

export ZSH="$HOME/.oh-my-zsh"
# Source Oh My ZSH
source $ZSH/oh-my-zsh.sh


###################
# Sources & Evals #
###################

# Source common
for file in ${DOT_DIR}/configs/zsh/*.zsh; do
    source "$file"
done

# Source Opam
[[ ! -r /Users/bryce/.opam/opam-init/init.zsh ]] || source /Users/bryce/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


# Source GHCup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# rbenv
eval "$(rbenv init -)"
# pyenv
eval "$(pyenv init -)"

# Load NVM
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

#########
# Alias #
#########

alias ip='ifconfig | grep "inet " | awk "NR == 2" | cut -f2 -d" "'
alias suroot='sudo -E -s'
alias convertm4as='for foo in *.m4a; do ffmpeg -i "$foo" -acodec libmp3lame -aq 2 "${foo%.m4a}.mp3"; done'
alias monogdb="brew services start mongodb-community"
alias monogdbstop="brew services stop mongodb-community"


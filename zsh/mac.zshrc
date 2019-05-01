# Load plugins
plugins=(
  git
  osx
  zsh-syntax-highlighting
  zsh-autosuggestions
)

export PATH="/usr/local/opt/openssl/bin:$PATH"

## Themes
ZSH_THEME='oxide'

# Export and Sources

## Add oh-my-zsh directory
export ZSH=/Users/brycethuilot/.oh-my-zsh
## Source zshrc
source $ZSH/oh-my-zsh.sh
## Add /usr/local/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
## Add /usr/local/sbin
export PATH="/usr/local/sbin:$PATH"
# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
# GPG
export GPG_TTY=$(tty)
# Export go path

# Alias
alias gac="git add . && git commit -m"
alias ip='ifconfig | grep "inet " | awk "NR == 2" | cut -f2 -d" "'
alias suroot='sudo -E -s'
alias ccis-linux='ssh login.ccs.neu.edu'

# Load rbenv
eval "$(rbenv init -)"

export LANG=en_US.UTF-8
export TERM=rxvt-256color

alias pastebin="curl -F 'clbin=<-' https://clbin.com"
alias wrbb='cd wordpress/wp-content/themes/WRBB-Site'
alias reload="source $HOME/.zshrc"
alias edit_zsh="nvim $HOME/.zshrc"
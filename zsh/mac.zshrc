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

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Export and Sources

## Add oh-my-zsh directory
export ZSH=$HOME/.oh-my-zsh
## Source zshrc
source $ZSH/oh-my-zsh.sh
## Add /usr/local/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
## Add /usr/local/sbin
export PATH="/usr/local/sbin:$PATH"
# ssh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
# GPG
export AWS_WRBB_PATH="$HOME/.wrbb.pem"

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
alias convertm4as='for foo in *.m4a; do ffmpeg -i "$foo" -acodec libmp3lame -aq 2 "${foo%.m4a}.mp3"; done'
export GOPATH="$HOME/.go"
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


#######################
# Exports & Variables # 
#######################

export ZSH="/home/bryce/.oh-my-zsh"
export GOPATH="$HOME/.go;$HOME/go;$HOME/Github"

##############
# ZSH Config #
##############

ZSH_THEME="oxide"
plugins=(git)

###########
# Sources #
###########

source $ZSH/oh-my-zsh.sh

#########
# Alias #
#########

alias clipboard="xclip -selection c"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm



#######################
# Exports & Variables # 
#######################

export ZSH="/home/bryce/.oh-my-zsh"
export GOPATH="$HOME/.go;$HOME/Github"

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

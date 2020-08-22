
#######################
# Exports & Variables # 
#######################

export PATH="$HOME/.rbenv/bin:$PATH"
export ZSH="/home/bryce/.oh-my-zsh"

##############
# ZSH Config #
##############

ZSH_THEME="nox"
plugins=(git)

###########
# Sources #
###########

source $ZSH/oh-my-zsh.sh

eval "$(rbenv init -)"

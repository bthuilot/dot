export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

# Alias OSX commands
# for use with common scripts
alias open=xdg-open
alias pbocpy="xclip -selection c"


###################
# Sources & Evals #
###################

# Source common
for file in ${DOT_DIR}/configs/zsh/*.zsh; do
    source "$file"
done



source $ZSH/oh-my-zsh.sh


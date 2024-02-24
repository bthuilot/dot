# reloads the current zshrc config
alias reload="source $HOME/.zshrc"

# easy way to add and commit all changes
alias gc="git commit --signoff -m"
alias ga="git add"

alias awsmfa="op get item aws --otp | aws-mfa"

alias dot="cd $DOT_DIR"

tem() {
    emacs -nw "$1"
}

compdef _files temacs
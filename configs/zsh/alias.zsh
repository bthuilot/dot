#!/bin/zsh

# reloads the current zshrc config
alias reload="source $HOME/.zshrc"

# easy way to add and commit all changes
alias gc="git commit --signoff -m"
alias ga="git add"

alias tffmt="terraform fmt -recursive"

alias awsmfa="op item get aws --otp | aws-mfa"

alias dot="cd $DOT_DIR"


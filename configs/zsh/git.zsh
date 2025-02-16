#!/bin/zsh
#
# Bryce Thuilot <bryce@thuilot.io>
# Copyright (C) 2024, GPL-3.0 License

# easy way to add and commit all changes
alias gc="git commit --signoff -m"
alias gm="git merge --no-edit"
alias gr="git rebase"
alias gmc="git commit --no-edit --signoff; git merge --continue"
alias ga="git add"
alias gf="git fetch origin"
alias gut="git untracked"
alias gpf="git push --force-with-lease"


#!/bin/zsh
#
# Bryce Thuilot <bryce@thuilot.io>
# Copyright (C) 2024, GPL-3.0 License

# Go to root of git repo
alias gitroot='cd $(git rev-parse --show-toplevel)'

# Get the last commit in short and long form
alias lastcommit='git log -1 --pretty=%h'
alias lastcommitlong='git log -1 --pretty=%H'

# easy way to add and commit all changes
alias gc="git commit --signoff -m"
alias gm="git merge --no-edit"
alias gmc="git commit --no-edit --signoff; git merge --continue"
alias gca='git commit --amend --no-edit --date="$(date -R)"'
alias gcaa='git add . && git commit --amend --no-edit --date="$(date -R)"'
alias gcam='git commit --amend --date="$(date -R)"'
alias ga="git add"
alias gf="git fetch origin"
alias gut="git untracked"
alias gpf="git push --force-with-lease"


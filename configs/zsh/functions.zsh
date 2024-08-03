#!/bin/zsh

# Logins to AWS ECR with current profile
ecr-login() {
    aws ecr get-login-password | docker login -u AWS --password-stdin "https://$(aws sts get-caller-identity --query 'Account' --output text).dkr.ecr.us-east-1.amazonaws.com"
}

# Opens the given file inside of emacs
em() {
    touch "$1"
    open -a Emacs "$1"
}
# Add completion for em
compdef _files emacs

# Opens the given file inside of emacs in the terminal
tem() {
    touch "$1"
    emacs -nw "$1"
}
# Add completion for tem
compdef _files temacs

# Opens the current git repository in the browser
github() {
    URL="$(git config --get remote.origin.url)" ||  { echo "No remote URL found"; return 1;}
    open "$(echo "${URL%.git}" | sed 's|:|/|;s|^git@|https://|')"
}

ntfy() {
    msg="${1:-Complete}"
    title="${2:-Terminal}"
    osascript -e "display notification \"${msg}\" with title \"$title\""
}
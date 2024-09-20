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

_git_https_link() {
    URL="$(git config --get remote.origin.url)" ||  { echo "No remote URL found"; return 1;}
    echo "$(echo "${URL%.git}" | sed 's|:|/|;s|^git@|https://|')"
}

# Opens the current git repository in the browser
grepo() {
    HTTPS_URL="$(_git_https_link)"
    open "${HTTPS_URL}"
}

# Opens the current git commit in the browser
# Only works for GitHub repos
ghcommit() {
    HTTPS_URL="$(_git_https_link)"
    open "${HTTPS_URL}/commit/$(git rev-parse HEAD)"
}

# Opens the current git branch in the browser
# Only works for GitHub repos
ghbranch() {
    HTTPS_URL="$(_git_https_link)"
    open "${HTTPS_URL}/tree/$(git branch --show-current)"
}

ghpulls() {
    if [ -z "$GITHUB_USER"]; then
	echo "no github user set"
    fi
    HTTPS_URL="$(_github_https_link)"
    open "${HTTPS_URL}/pulls/${GITHUB_USER}"
}

ntfy() {
    msg="${1:-Complete}"
    title="${2:-Terminal}"
    osascript -e "display notification \"${msg}\" with title \"$title\""
}
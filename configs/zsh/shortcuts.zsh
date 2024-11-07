#!/bin/zsh
#
# Bryce Thuilot <bryce@thuilot.io>
# Copyright (C) 2024, GPL-3.0 License

echo "loaded shortcuts"


# reloads the current zshrc config
alias reload="source $HOME/.zshrc"

alias tffmt="terraform fmt -recursive"

alias awsmfa="op item get aws --otp | aws-mfa"

alias dot="cd \$DOT_DIR"

if [[ $(uname) == "Darwin" ]]; then
  alias ip='ifconfig | grep "inet " | awk "NR == 2" | cut -f2 -d" "'
  alias suroot='sudo -E -s'
  alias convertm4as='for foo in *.m4a; do ffmpeg -i "$foo" -acodec libmp3lame -aq 2 "${foo%.m4a}.mp3"; done'
  alias monogdb="brew services start mongodb-community"
  alias monogdbstop="brew services stop mongodb-community"
else
  # Alias OSX commands
  # for use with common scripts
  alias open=xdg-open
  alias pbocpy="xclip -selection c"
fi


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
    if [ -z "$GITHUB_USER" ]; then
	echo "no github user set"
    fi
    HTTPS_URL="$(_git_https_link)"
    open "${HTTPS_URL}/pulls/${GITHUB_USER}"
}

ntfy() {
    msg="${1:-Complete}"
    title="${2:-Terminal}"
    osascript -e "display notification \"${msg}\" with title \"$title\""
}
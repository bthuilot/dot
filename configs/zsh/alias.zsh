#!/bin/zsh

# reloads the current zshrc config
alias reload="source $HOME/.zshrc"

# Go to root of git repo
alias gitroot='cd $(git rev-parse --show-toplevel)'

# easy way to add and commit all changes
alias gc="git commit --signoff -m"
alias gm="git merge --no-edit"
alias ga="git add"

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


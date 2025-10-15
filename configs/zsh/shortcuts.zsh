#!/bin/zsh
# Copyright (C) 2017-2025 Bryce Thuilot <bryce@thuilot.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the FSF, either version 3 of the License, or (at your option) any later version.
# See the LICENSE file in the root of this repository for full license text or
# visit: <https://www.gnu.org/licenses/gpl-3.0.html>.

# reloads the current zshrc config
alias reload="source $HOME/.zshrc"

alias tffmt="terraform fmt -recursive"

alias awsmfa="op item get aws --otp | aws-mfa"

alias dot="cd \$DOT_DIR"

# Install the base components for a new
alias opambase="opam install ocaml-lsp-server odoc ocamlformat utop"

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
	mkdir -p "$(dirname $1)"
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

ntfy() {
	msg="${1:-Complete}"
	title="${2:-Terminal}"
	osascript -e "display notification \"${msg}\" with title \"$title\""
}

dotenv() {
	file="${1:-.env}"
	if ! test -f $file; then
		echo "ERROR: file '${file}' does not exist" 1>&2
		return 1
	fi

	export $(grep -v '^#' $file | xargs)
}

docker-shell() {
    img="$1"
    shell="${2:-/bin/bash}"

    docker run --rm -it --entrypoint "$shell" "$img"
}
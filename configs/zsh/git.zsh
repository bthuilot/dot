#!/bin/zsh
# Copyright (C) 2017-2025 Bryce Thuilot <bryce@thuilot.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the FSF, either version 3 of the License, or (at your option) any later version.
# See the LICENSE file in the root of this repository for full license text or
# visit: <https://www.gnu.org/licenses/gpl-3.0.html>.

# easy way to add and commit all changes
alias gc="git commit --signoff -m"
alias gm="git merge --no-edit"
alias gr="git rebase"
alias gmc="git commit --no-edit --signoff; git merge --continue"
alias ga="git add"
alias gf="git fetch origin"
alias gut="git untracked"
alias gpf="git push --force-with-lease"

_git_https_link() {
	URL="$(git config --get remote.origin.url)" || {
		echo "No remote URL found"
		return 1
	}
	echo "$(echo "${URL%.git}" | sed 's|:|/|;s|^git@|https://|')"
}

# Opens the current git repository in the browser
grepo() {
	HTTPS_URL="$(_git_https_link)"
	open "${HTTPS_URL}"
}

# Opens the current git commit in the browser
gcommit() {
	HTTPS_URL="$(_git_https_link)"
	case $HTTPS_URL in
	https://github.com/*)
		open "${HTTPS_URL}/commit/$(git rev-parse HEAD)"
		;;
	https://gitlab.com/*)
		open "${HTTPS_URL}/-/commit/$(git rev-parse HEAD)"
		;;
	esac
}

# Opens the current git branch in the browser
gbranch() {
	HTTPS_URL="$(_git_https_link)"
	case $HTTPS_URL in
	https://github.com/*)
		open "${HTTPS_URL}/tree/$(git branch --show-current)"
		;;
	https://gitlab.com/*)
		open "${HTTPS_URL}/-/tree/$(git branch --show-current)?ref_type=heads"
		;;
	esac
}

gpulls() {
	HTTPS_URL="$(_git_https_link)"
	case $HTTPS_URL in
	https://github.com/*)
		if [ -z "$GITHUB_USER" ]; then
			echo "no github user set"
			return 1
		fi
		open "${HTTPS_URL}/pulls/${GITHUB_USER}"
		;;
	https://gitlab.com/*)
		if [ -z "$GITLAB_USER" ]; then
			echo "no gitlab user set"
			return 1
		fi
		open "${HTTPS_URL}/-/merge_requests/?author_username=${GITLAB_USER}"
		;;
	esac
}

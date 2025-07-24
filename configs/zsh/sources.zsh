#!/bin/zsh
# Copyright (C) 2017-2025 Bryce Thuilot <bryce@thuilot.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the FSF, either version 3 of the License, or (at your option) any later version.
# See the LICENSE file in the root of this repository for full license text or
# visit: <https://www.gnu.org/licenses/gpl-3.0.html>.


###########
# Sources #
###########

# Source Opam
[[ ! -r /Users/bryce/.opam/opam-init/init.zsh ]] || source /Users/bryce/.opam/opam-init/init.zsh >/dev/null 2>/dev/null

# Source GHCup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Load NVM
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

#########
# Eval #
########

# rbenv
command -v rbenv >/dev/null && eval "$(rbenv init -)"
# pyenv
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# dot

install scripts and dotfiles for macOS and Linux (Arch)

## Installation

```shell
# OS should be either 'macos' or 'linux'
curl -L $OS.install.bryce.in | bash

# follow the prompts to complete installation
```


## Repository Structure

```
.
├── configs
│   ├── elisp
│   │   └── *.el              # common elisp files
│   ├── zsh
│   │   └── *.zsh             # common zsh files
│   ├── git
│   │   ├── global.gitignore  # global gitignore file
│   │   └── *.gitconfig       # gitconfig files
│   ├── links                 # files that need to be sysmtem linked to other location
│   └── *                     # other config files
│
├── templates                 # templates that are used to generate config files that are not tracked
│                             # see README.txt in folder
└── scripts
    ├── install
    │   ├── linux.sh          # install script for linux
    │   ├── macos.sh          # install script for macos
    │   └── *.sh              # tool specific install script
    └── pre-install
        ├── mac.sh            # pre-install script for macos
        └── linux.sh          # pre-install script for linux
```

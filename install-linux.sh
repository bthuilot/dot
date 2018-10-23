#!/bin/bash

set -e

# Install Trizen - RIP Pacaur :(
git clone https://aur.archlinux.org/trizen.git
pushd trizen
makepkg -sri
popd
rm -rf trizen

# Copy Files
mkdir -p ~/.config/
cp -r i3/ ~/.config/
cp -r polybar/ ~/.config/
cp -r termite/ ~/.config/
for file in System/*
do
  cp $file ~/.$file
done

SYSTEM="zsh git wget dkms ninja graphviz light dmenu"
WIRELESS="openssh networkmanager network-manager-applet stalonetray wireless_tools"
DISPLAY="xorg-server xorg xorg-apps xorg-init i3"
PACKAGES="vim neovim feh atom google-chrome-stable"
SOUND="alsa-lib pulseaudio playerctl i3lock-fancy-git compton"
FUN="ttf-google-fonts-git ttf-font-awesome spotify"

# Install
trizen -S $SYSTEM $WIRELESS $DISPLAY $PACKAGES $SOUND $FUN


# Install my fav font
fc-query ../Universal/KnackFont.ttf
fc-cache


sudo systemctl enable NetworkManager

# Make build dir
mkdir -p builddir


read -p "Set up MacBook14 track pad? [Y/n]" setUpTrackPad
if [[ setUpTrackPad -ne 'n' ]]; then

  trizen -S macbook12-spi-driver-dkms
  # Set up touch pad
  cd builddir
  git clone git://anongit.freedesktop.org/wayland/libinput
  cd libinput

  ## Download patch
  wget https://gist.githubusercontent.com/peterychuang/5cf9bf527bc26adef47d714c758a5509/raw/eace1794287bb2e9903f7a7f3c6e2496346b321e/0001-udev-Add-Apple-SPI-Keyboard-and-Touchpad.patch

  ### Get patch
  git apply 0001-udev-Add-Apple-SPI-Keyboard-and-Touchpad.patch

  ### Build patch
  meson --prefix=/usr builddir/
  ninja -C builddir/
  sudo ninja -C builddir/ install
  sudo udevadm hwdb --update

  cd

  # TODO add this to the correct file
  echo "Option \"ClickMethod\" \"clickfinger\""
fi
# Background
mkdir -p ~/.background/
cp archBackgrounds.zip ~/.background/
unzip ~/.background/archBackgrounds.zip
cp ~/.background/archBackgrounds/* ~/.background/
rm -f ~/.background/archBackgrounds.zip

# Change to ZSH
chsh -s /usr/bin/zsh

## Download OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# RUBY :D

## Download and install
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

cd ~/.rbenv && src/configure && make -C src

# Init ruby
~/.rbenv/bin/rbenv init
cd

## Check to make sure
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

#Install Ruby :)

VERSION="2.4.2"
rbenv install $VERSION

# Move from usb
read -p "Do you want to install files from USB [Y/n]" installFromUSB
# TODO get correct USBLOCATION
USBLOCATION=/Volumes/USB

if [[ installFromUSB -ne 'n' ]]; then
  # Move SSH
  mkdir -p ~/.ssh
  cp $USBLOCATION/Keys/SSH/id* ~/.ssh/
  ssh-add

  # Move GPG
  gpg2 --import $USBLOCATION/Keys/GPG/pub.asc
  gpg2 --import $USBLOCATION/Keys/GPG/sec.asc

  # Install git essentails
  read -p "Set up git as Bryce? [Y/n]" setUpGit
  if [[ setUpGit -ne 'n' ]]; then
    git config --global user.name "Bryce Thuilot"
    git config --global user.email bthuilot@gmail.com
    git config --global commit.gpgsign true
    git config --global gpg.program gpg2
    git config --global user.signingkey $(gpg2 --list-secret-keys --keyid-format LONG | grep sec |awk -F'/' '{print $2}' | awk -F' ' '{print $1}')
  fi

fi

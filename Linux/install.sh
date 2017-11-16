#!/bin/sh

#Install Pacuar

if ! command -v pacaur >/dev/null; then
    tmp=$(mktemp -d)
    function finish {
        rm -rf "$tmp"
    }
    trap finish EXIT

    pushd $tmp
    for pkg in cower pacaur; do
        curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=$pkg && \
            makepkg --needed --noconfirm --skippgpcheck -sri
    done
    popd

    if ! command -v pacaur >/dev/null; then
        >&2 echo "Pacaur wasn't successfully installed"
        exit 1
    fi
fi


# Copy Files
cp -r i3 ~/.config
cp -r polybar ~/.config
cp -r termite ~/.config
for file in System/*
do
  mv $file ~/.$file
done


# Install my fav font
fc-query KnackFont.ttf
fc-cache



SYSTEM="zsh git wget dkms macbook12-spi-driver-dkms ninja graphviz light"
WIRELESS="openssh networkmanager network-manager-applet stalonetray wireless_tools"
DISPLAY="xorg-server xorg xorg-apps xorg-init i3"
PACKAGES="vim neovim feh atom google-chrome-stable"
SOUND="alsa-lib pulseaudio playerctl i3lock-fancy-git compton"
FUN="ttf-google-fonts-git ttf-font-awesome spotify"


# Install
pacaur -S $SYSTEM $WIRELESS $DISPLAY $PACKAGES $SOUND $FUN

sudo systemctl enable NetworkManager

# Make build dir
mkdir -p builddir




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

echo "Option \"ClickMethod\" \"clickfinger\""



# Set up OhMyZsh
chsh -s /usr/bin/zsh

## Download OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# RUBY :D

## Download and install
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

cd ~/.rbenv && src/configure && make -C src

# Init
~/.rbenv/bin/rbenv init

## Check to make sure
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build 

#Install Ruby :)

VERSION="2.4.2"
rbenv install 2.4.2



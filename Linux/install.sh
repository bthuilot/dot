#!/bin/sh


# Copy Files
cp -r i3 ~/.config
cp -r polybar ~/.config
for file in System/*
do
  mv $file ~/.$file
done

fc-query KnackFont.ttf
fc-cache

SYSTEM="zsh git"
DISPLAY="xorg-server xorg xorg-apps xorg-init i3"
PACKAGES="neovim feh"

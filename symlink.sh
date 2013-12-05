#!/bin/bash

cd /home/$USER/dotfiles/ &&
git submodule init &&
git submodule update &&
ln -s /home/$USER/dotfiles/alias.zsh /home/$USER/dotfiles/.oh-my-zsh/custom/alias.zsh
ln -s /home/$USER/dotfiles/.alsoftrc /home/$USER/.alsoftrc
ln -s /home/$USER/dotfiles/.i3 /home/$USER/.i3
ln -s /home/$USER/dotfiles/.i3/i3status.conf /home/$USER/.i3status.conf
ln -s /home/$USER/dotfiles/.oh-my-zsh /home/$USER/.oh-my-zsh
mkdir -p /home/$USER/.config/terminator
ln -s /home/$USER/dotfiles/terminatorconfig /home/$USER/.config/terminator/config
ln -s /home/$USER/dotfiles/.vimrc.local /home/$USER/.vimrc.local
ln -s /home/$USER/dotfiles/.xinitrc /home/$USER/.xinitrc
ln -s /home/$USER/dotfiles/.zprofile /home/$USER/.zprofile
ln -s /home/$USER/dotfiles/.zshrc /home/$USER/.zshrc

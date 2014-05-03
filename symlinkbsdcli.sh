#!/usr/local/bin/zsh

cd /home/$USER/dotfiles/ &&
git submodule init &&
git submodule update &&
ln -s /home/$USER/dotfiles/.oh-my-zsh /home/$USER/.oh-my-zsh
ln -s /home/$USER/dotfiles/.vimrc.local /home/$USER/.vimrc.local
ln -s /home/$USER/dotfiles/.vimrc.before.local /home/$USER/.vimrc.before.local
ln -s /home/$USER/dotfiles/.zshrc /home/$USER/.zshrc

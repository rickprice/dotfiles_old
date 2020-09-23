#! /bin/sh

# Ensure Vundle etc is in the directory
git submodule init
git submodule update

# Setup the directories
stow zsh
stow bash
stow vim
stow local

vim +PluginInstall +qall
vim +PluginClean +qall

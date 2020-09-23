#! /bin/sh

# Ensure Vundle etc is in the directory
git submodule init
git submodule update

# Setup the directories
stow zsh
stow bash
stow vim

vim +PluginInstall +qall
vim +PluginClean +qall

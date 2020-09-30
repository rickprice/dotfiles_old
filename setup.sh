#! /bin/sh

# Setup the directories
stow zsh
stow bash
stow vim
stow local
stow config
stow shell_snippets

vim +PlugInstall +qall
#vim +PlugClean +qall
#vim +PlugUpdate

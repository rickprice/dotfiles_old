#! /bin/sh

# Download vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup the directories
stow zsh
stow bash
stow vim
stow local
stow shell_snippets

vim +PlugInstall +qall
vim +PlugClean +qall

#! /bin/sh

# Download plug.vim for NeoVim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

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

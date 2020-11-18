#! /bin/sh

# Download plug.vim for NeoVim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Setup the directories
mkdir -p ~/.cache/nvim/undo
stow zsh
stow bash
stow vim
stow local
stow config
stow shell_snippets

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

vim +PlugInstall +qall
#vim +PlugClean +qall
#vim +PlugUpdate

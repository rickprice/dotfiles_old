#! /bin/sh

# Download plug.vim for NeoVim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

### Configure Vim to use Neovim configuration ###
# nvim conf dir: ~/.config/nvim
# vim conf dir: ~/.vim
# link the 1st as the 2nd with relative links

# Prepare a vimrc file in ~/.config/nvim folder
ln -sf ./init.vim ~/.config/nvim/vimrc

# Link the whole ~/.config/nvim folder as ~/.vim foler
ln -sf ./.config/nvim ~/.vim

### Setup dotfiles directories ###

# Setup the directories
mkdir -p ~/.cache/nvim/undo
stow --dotfiles zsh
stow --dotfiles bash
#stow --dotfiles vim
stow --dotfiles local
stow --dotfiles config

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

### Configure Vim plugins ###

vim +PlugInstall +qall
#vim +PlugClean +qall
#vim +PlugUpdate

### Configure ZSH things ###

# ZSH Plugins with Antibody
antibody bundle < ~/.config/antibody/zsh_plugins.txt > shell_snippets/.shell_snippets/zsh_plugins.sh
chmod a+x shell_snippets/.shell_snippets/zsh_plugins.sh

### Configure Shell snippets ###

# Have to run stow on shell_snippets after we have set them up with antibody
stow --dotfiles shell_snippets

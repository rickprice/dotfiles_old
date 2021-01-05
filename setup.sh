#! /bin/sh

### Setup dotfiles directories ###

mkdir -p ~/.cache/nvim/undo
stow --dotfiles zshrc
stow --dotfiles bash
stow --dotfiles vim
stow --dotfiles local
stow --dotfiles config
stow --dotfiles tmux

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

### Configure ZSH things ###

# ZSH Plugins with Antibody
antibody bundle < config/.config/antibody/zsh_plugins.txt > shell_snippets/.shell_snippets/zsh_plugins.sh
chmod a+x shell_snippets/.shell_snippets/zsh_plugins.sh

### Configure Shell snippets ###

# Have to run stow on shell_snippets after we have set them up with antibody
stow --dotfiles shell_snippets

# Prepare a vimrc file in ~/.config/nvim folder
ln -sf ~/.config/nvim/init.vim ~/.vimrc

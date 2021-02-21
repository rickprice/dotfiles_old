#!/bin/bash

# From cloud
ln -sf $DOTFILES_CLOUD/tmuxp $XDG_CONFIG_HOME/tmuxp

if [ ! -d $XDG_CONFIG_HOME/tmux ]
  then
    mkdir $XDG_CONFIG_HOME/tmux
    git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
    $XDG_CONFIG_HOME/tmux/plugins/tpm/bin/install_plugins
fi

ln -sf $DOTFILES/tmux/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf

if [ ! -d $XDG_CONFIG_HOME/tmux/plugins/tpm ]
then
    git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
fi


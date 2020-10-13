#! /bin/bash

# Install PPA tools
sudo apt-get --assume-yes update && apt-get -yqq upgrade && \
        apt-get --assume-yes install \
    software-properties-common \
    curl \
    bash \
    && apt-get -y clean

# Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
# Node
sudo curl -L https://deb.nodesource.com/setup_14.x | bash -
# Yarn
sudo curl -L https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Software I use all the time, stow is pretty important
sudo apt-get --assume-yes update && apt-get -yqq upgrade && \
        apt-get --assume-yes install \
    ripgrep \
    stow \
    universal-ctags \
    golang \
    locales \
    && apt-get -y clean

# Python setup, including for coc-nvim
sudo apt-get --assume-yes update && apt-get -yqq upgrade && \
        apt-get --assume-yes install \
    python3 \
    python3-pip \
    python-is-python3 \
    flake8 \
    black \
    mypy \
    mypy-doc \
    python-black-doc \
    python3-pynvim \
    python3-venv \
    && apt-get -y clean


# Things needed for coc-nvim
sudo apt-get --assume-yes update && apt-get -yqq upgrade && \
        apt-get --assume-yes install \
    neovim \
    nodejs \
    yarn \
    && apt-get -y clean

# Install Git
sudo add-apt-repository -y ppa:git-core/ppa && apt-get update && apt-get install -y git git-lfs && apt-get -y clean

# Neovim module setup
sudo yarn global add neovim
sudo npm install -g neovim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/view view /usr/bin/nvim 60

# This is needed for coc-python
sudo pip3 install jedi

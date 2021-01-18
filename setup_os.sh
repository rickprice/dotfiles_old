#! /bin/bash

# Install PPA tools
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
    software-properties-common \
    curl \
    bash \
    && sudo apt-get -y clean

# Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
# Node
sudo curl -L https://deb.nodesource.com/setup_14.x | sudo bash -
# Yarn
sudo curl -L https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Software I use all the time, stow is pretty important
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
    ripgrep \
    stow \
    universal-ctags \
    golang \
    locales \
    fd-find \
    fzf \
    vifm \
    dos2unix \
    colorized-logs \
    pass \
    mutt \
    && sudo apt-get -y clean

# Needed for vim-clap and vim-todoist
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
        libssl-dev \
        build-essential \
    && sudo apt-get -y clean

# Interesting software.
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
        figlet \
    && sudo apt-get -y clean

# Python setup, including for coc-nvim
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
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
    && sudo apt-get -y clean

# Perl setup
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
    libcode-tidyall-perl \
    libdbd-pg-perl \
    cpanminus \
    && sudo apt-get -y clean

# Things needed for coc-nvim
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
    neovim \
    nodejs \
    yarn \
    && sudo apt-get -y clean

# Things needed for oh-my-zsh
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
    build-essential \
    curl \
    file \
    powerline \
    fonts-powerline \
    && sudo apt-get -y clean

# Tmux stuff
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
    tmux \
    && sudo apt-get -y clean

sudo gem install tmuxinator

# Install Git
sudo add-apt-repository -y ppa:git-core/ppa && sudo apt-get update && sudo apt-get install -y git git-lfs && sudo apt-get -y clean
# Set default pull mode for git
git config --global pull.rebase false

# Neovim module setup
sudo yarn global add neovim
sudo npm install -g neovim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --install /usr/bin/view view /usr/bin/nvim 60

# This is needed for coc-python
sudo pip3 install jedi

# Iosevka Font which I like
rm -rf /tmp/iosevka
mkdir -p /tmp/iosevka
wget --directory-prefix=/tmp/iosevka http://phd-sid.ethz.ch/debian/fonts-iosevka/fonts-iosevka_4.0.0%2Bds-1_all.deb
sudo dpkg -i /tmp/iosevka/fonts-iosevka_4.0.0+ds-1_all.deb

# Install dependencies needed for Alacritty Terminal
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustup override set stable
rustup update stable

# Install Alacritty
rm -rf /tmp/alacritty
git clone https://github.com/alacritty/alacritty.git /tmp/alacritty
cd /tmp/alacritty

cargo build --release

sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

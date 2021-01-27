#! /bin/bash

# Install base tools
sudo apt-get --assume-yes update && sudo apt-get -yqq upgrade && \
        sudo apt-get --assume-yes install \
    software-properties-common \
    curl \
    bash \
    python3 \
    python3-pip \
    python-is-python3 \
    && sudo apt-get -y clean

pip3 install ansible

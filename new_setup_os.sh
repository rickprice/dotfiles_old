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

# Bootstrap Ansible
pip3 install ansible
pip3 install python3-apt # This is so that we can add and remove PPA's

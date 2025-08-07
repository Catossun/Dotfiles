#!/bin/bash
# Setup nvim

set -e

echo 'Installing nvim...'

# Download nvim.appimage to /usr/bin/nvim
sudo curl -sfLo /usr/bin/nvim https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.appimage
sudo chmod a+x /usr/bin/nvim

# Install FUSE library to run app image
sudo apt update >> /dev/null 2>&1
sudo apt install libfuse2 -y >> /dev/null 2>&1

nvim --version >> /dev/null && echo 'Install success!'

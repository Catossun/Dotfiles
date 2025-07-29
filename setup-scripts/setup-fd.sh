#!/bin/sh

set -e

echo "Installing fd..."

sudo apt update >> /dev/null 2>&1
sudo apt install -y fd-find  >> /dev/null 2>&1

ln -s $(which fdfind) ~/.local/bin/fd

fd --version && echo "Install success!"

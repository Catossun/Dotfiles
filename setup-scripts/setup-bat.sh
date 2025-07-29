#!/bin/sh

set -e

echo "Installing bat..."

sudo apt update >> /dev/null 2>&1
sudo apt install -y bat  >> /dev/null 2>&1

ln -s $(which batcat) ~/.local/bin/bat

bat --version && echo "Install success!"

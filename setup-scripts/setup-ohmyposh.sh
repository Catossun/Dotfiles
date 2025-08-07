#!/bin/sh

set -e

echo "Installing oh-my-posh..."

sudo apt update > /dev/null 2>&1
sudo apt install unzip -y > /dev/null 2>&1
curl -s https://ohmyposh.dev/install.sh | bash -s

echo "Install success!"

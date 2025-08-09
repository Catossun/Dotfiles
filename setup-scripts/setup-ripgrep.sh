#!/bin/sh

set -e

echo "Installing ripgrep..."

curl -sfLo /tmp/ripgrep.deb https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb

sudo apt install /tmp/ripgrep.deb

rg --version && echo "Install success!"

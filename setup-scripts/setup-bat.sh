#!/bin/sh

set -e

echo "Installing bat..."

curl -sfLo /tmp/bat.deb https://github.com/sharkdp/bat/releases/download/v0.25.0/bat_0.25.0_amd64.deb

sudo apt install /tmp/bat.deb

bat --version && echo "Install success!"

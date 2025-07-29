#!/bin/sh

echo "Installing fzf..."

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

fzf --version && echo "Install success!"

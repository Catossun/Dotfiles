#!/bin/bash
# Setup exa

set -e

echo 'Installing exa...'
exa_url=`curl -sL https://api.github.com/repos/ogham/exa/releases/latest | grep -Eo 'https://github.com/ogham/exa/releases/download/v.+/exa-linux-x86_64-v.+\.zip'`
cd $(mktemp -d)
curl -sfLo exa.zip $exa_url
unzip exa.zip
sudo mv bin/exa /usr/bin/
sudo mv man/exa.1 /usr/share/man/man1/
sudo mv man/exa_colors.5 / usr/share/man/man5
exa --version >> /dev/null && echo 'Install success!'

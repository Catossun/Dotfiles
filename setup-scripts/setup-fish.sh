#!/bin/sh

set -e

echo 'Installing fish...'

# Add fish-shell repository
sudo apt-add-repository -y ppa:fish-shell/release-4 >> /dev/null
sudo apt update >> /dev/null 2>&1
sudo apt install -y fish  >> /dev/null 2>&1

# Setup fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |\
  fish -c 'source && fisher install jorgebucaran/fisher && fisher update'

cat << EOF
Install fish success!
You can now run "chsh" to change your default shell:
$ chsh -s /usr/bin/fish
EOF

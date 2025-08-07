# Webb's Dotfiles

## TL;DR

```sh
# Clone dotfile as bare repo
git clone --bare ssh://git@gitlab.weikeup.cc:2222/weikeup/dotfiles.git dotfiles

# Set alias for dotfiles repo
alias df='git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'

# Hide untracked files to keep status clean
df config status.showUntrackedFiles no

# Load dotfiles
df checkout main

# Load submoudles
df submodule init && df submodule update

# [Optional] Install all tools
find ~/setup-scripts/ -maxdepth 1 -type f -executable -name '*.sh' -exec {} \;

# [Optional] Set fish as current user shell
fish --version && chsh -s $(which fish)
```

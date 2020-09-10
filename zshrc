# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Created by newuser for 5.3.1

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Load zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=248,underline"

# Load spaceship theme
export SPACESHIP_DOCKER_SHOW="false"
zinit light denysdovhan/spaceship-prompt

# Load typewritten theme
# export TYPEWRITTEN_SYMBOL="->"
# export TYPEWRITTEN_PROMPT_LAYOUT="pure"
# export TYPEWRITTEN_CURSOR="block"
# export TYPEWRITTEN_COLOR_MAPPINGS="primary:105;secondary:41;accent:22"
# fpath+=$HOME/.zsh/typewritten
# autoload -U promptinit; promptinit
# prompt typewritten

# Set TERM to xterm-256color
export TERM="xterm-256color"

alias gs="git status"
alias gc="git commit"
alias ga="git add"

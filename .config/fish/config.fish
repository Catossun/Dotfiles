status is-interactive || exit

fish_add_path ~/.local/bin

# Init Oh-My-Posh
if which oh-my-posh > /dev/null
	oh-my-posh init fish -c ~/.config/ohmyposh/di4am0nd.omp.json | source
end

if which batcat > /dev/null
  set -x BAT_THEME 'TwoDark'
  alias cat="batcat"
end

# Git Aliases
if which git > /dev/null
  alias gs="git status"
  alias ga="git add"
  alias gl="git log"
  alias gc="git commit"
  alias gpull="git pull"
  alias gpush="git push"
  alias gre="git reset"
  alias gch="git checkout"
  alias gd="git difftool"
  alias gb="git branch"
  alias gt="git tag"
  alias g="git"
end

# Docker Aliases
if which docker > /dev/null
  alias d="docker"
  alias dimgs="docker images"
  alias dps="docker ps"
  alias hugo='docker run --rm -it -p 1313:1313 -v $(pwd):/src -u 1000 klakegg/hugo'
end

# Tool Aliases
alias diff="vimdiff"
alias posh='powershell.exe'
alias h='history'
which lazygit > /dev/null && alias lg='lazygit'
which peco > /dev/null && alias peco='peco --layout bottom-up'

# Neovim Aliases
if which nvim > /dev/null
  alias nv='nvim'
  alias vim='nvim'
end

if which exa > /dev/null
  alias ls='exa'
  alias l='exa'
  alias la='exa -al --icons'
  alias ll='exa -l'
  alias tree='exa --tree --icons'
end

# Typo Aliases
alias sl="ls"

# Kubectl Aliases
alias mk="minikube kubectl --"
alias k="kubectl"

# Defined in /usr/share/fish/functions/fish_title.fish @ line 1
function fish_title
    # emacs' "term" is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS; or string match -vq '*,term:*' -- $INSIDE_EMACS
        # If we're connected via ssh, we print the hostname.
        set -l ssh
        set -q SSH_TTY
        and set ssh "["(prompt_hostname | string sub -l 20 | string collect)"]"
        # An override for the current command is passed as the first parameter.
        # This is used by `fg` to show the true process name, among others.
        if set -q argv[1]
            echo -- $ssh (string sub -l 20 -- $argv[1]) (prompt_pwd -d 1 -D 1)
        else
            # Don't print "fish" because it's redundant
            set -l command (status current-command)
            if test "$command" = fish
                set command
            end
            echo -- $ssh (string sub -l 20 -- $command) (prompt_pwd -d 1 -D 1)
        end
    end
end

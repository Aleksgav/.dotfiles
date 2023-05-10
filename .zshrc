export TERM="xterm-256color"

eval "$(/opt/homebrew/bin/brew shellenv)"

export GOPATH=$(go env GOPATH)

export PATH="/usr/local/sbin:$GOPATH/bin:$PATH"

# Explicitly set language
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='vim'

# History time stamp
HIST_STAMPS="dd.mm.yyyy"

# Aliases
alias zshconfig="vim ~/.zshrc"

# need for sheldon
export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

source ~/.rvm/scripts/rvm
source ~/.gvm/scripts/gvm

export PATH="$HOME/.config/emacs/bin:$PATH"

export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

eval "$(sheldon source)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

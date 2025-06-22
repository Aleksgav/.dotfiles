export TERM="xterm-256color"

#homebrew
# eval "$(/opt/homebrew/bin/brew shellenv)"

export GOPATH=$(go env GOPATH)

export PATH="/usr/local/sbin:$GOPATH/bin:$PATH"

# Explicitly set keyboard layouts
setxkbmap us,ru
setxkbmap -option grp:switch,grp:win_space_toggle

# Explicitly set language
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nvim'

# History time stamp
HIST_STAMPS="dd.mm.yyyy"

# Aliases
alias zshconfig="nvim ~/.zshrc"

# need for sheldon
export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

#source ~/.rvm/scripts/rvm
#source ~/.gvm/scripts/gvm

export PATH="$HOME/.config/emacs/bin:$PATH"

export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

eval "$(sheldon source)"

# This should run only once for user session
# Remove this to another place
find ~/.ssh -name 'id_*' ! -name '*.pub' -exec ssh-add -q {} \;
doom env -a '^SSH_' &> /dev/null

# emacs vterm integgration
vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias n='NVIM_APPNAME=nvim-lazy nvim' # LazyVim
alias nz='NVIM_APPNAME=nvim-zero nvim' # ZeroVim
alias ng='NVIM_APPNAME=nvim-ng nvim' # ZeroNG
nv() {
  select config in lazy
  do NVIM_APPNAME=nvim-$config nvim $@; break; done
}

nnv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

alias fng='ng $(fzf --preview "bat {} --color=always")'

alias cgb='git branch --sort=-committerdate | fzf --header "Checkout Branch" --preview "git diff --color=always {1}" --pointer="" | xargs git checkout'


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"
eval "$(mise activate zsh)"

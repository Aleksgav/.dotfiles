export TERM="xterm-256color"

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

# zinit
source /usr/local/opt/zinit/zinit.zsh

zinit load robbyrussell/oh-my-zsh
zinit load zsh-users/zsh-autosuggestions
#zinit ice as"completion"
zinit load zsh-users/zsh-completions
#zinit ice as"completion"
zinit load greymd/docker-zsh-completion
zinit load zsh-users/zsh-history-substring-search
zinit load zsh-users/zsh-syntax-highlighting
zinit load mkwmms/plugin-osx
zinit load djui/alias-tips

zinit snippet OMZ::plugins/bundler
zinit snippet OMZ::plugins/cabal
zinit snippet OMZ::plugins/capistrano 
zinit snippet OMZ::plugins/common-aliases
zinit snippet OMZ::plugins/encode64
zinit snippet OMZ::plugins/gem
zinit snippet OMZ::plugins/gpg-agent
zinit snippet OMZ::plugins/git
zinit snippet OMZ::plugins/golang
zinit snippet OMZ::plugins/history
zinit snippet OMZ::plugins/node
zinit snippet OMZ::plugins/npm
zinit snippet OMZ::plugins/pip
zinit snippet OMZ::plugins/python
zinit snippet OMZ::plugins/rails
zinit snippet OMZ::plugins/rake
zinit snippet OMZ::plugins/ruby
zinit snippet OMZ::plugins/rvm
zinit snippet OMZ::plugins/ssh-agent
#zinit snippet OMZ::plugins/tmux
zinit snippet OMZ::plugins/vagrant
#zinit snippet OMZ::plugins/vi-mode
zinit snippet OMZ::plugins/yarn
zinit snippet OMZ::plugins/zsh_reload
zinit snippet OMZ::plugins/kubectl

zinit pack for fzf

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


source ~/.rvm/scripts/rvm
source ~/.gvm/scripts/gvm

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH="$HOME/.emacs.d/bin:$PATH"

export STARSHIP_CONFIG=~/.starship.toml
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

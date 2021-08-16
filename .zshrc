export TERM="xterm-256color"

export GOPATH=$(go env GOPATH)

export PATH="/usr/local/sbin:$GOPATH/bin:$PATH"

# Explicitly set language
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim'


# liquid prompt
LP_PS1_POSTFIX=$'\uE0B1 '
LP_ENABLE_TIME=1
LP_ENABLE_JOBS=1

# History time stamp
HIST_STAMPS="dd.mm.yyyy"

# Aliases
alias zshconfig="vim ~/.zshrc"

# zinit
source /usr/local/opt/zinit/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit load robbyrussell/oh-my-zsh
zinit ice as"completion"
zinit load zsh-users/zsh-autosuggestions
zinit ice as"completion"
zinit load zsh-users/zsh-completions
zinit ice as"completion"
zinit load djui/alias-tips
zinit ice as"completion"
zinit load greymd/docker-zsh-completion
zinit load zsh-users/zsh-history-substring-search
zinit load zsh-users/zsh-syntax-highlighting
zinit load mkwmms/plugin-osx

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
zinit snippet OMZ::plugins/vi-mode
zinit snippet OMZ::plugins/yarn
zinit snippet OMZ::plugins/zsh_reload
zinit snippet OMZ::plugins/kubectl

source ~/.rvm/scripts/rvm
source ~/.gvm/scripts/gvm

export GOPATH=$HOME/go
PATH=$PATH:$GOPATH/bin

export STARSHIP_CONFIG=~/.starship.toml
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

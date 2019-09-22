export TERM="xterm-256color"

export PATH="/usr/local/sbin:$PATH"

# Explicitly set language
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim'


# liquid prompt
LP_PS1_POSTFIX='> '

# History time stamp
HIST_STAMPS="dd.mm.yyyy"


# Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Zplug
source ~/.zplug/init.zsh

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", defer:0

zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer: 2
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug 'plugins/bundler', from:oh-my-zsh
zplug 'plugins/cabal', from:oh-my-zsh
zplug 'plugins/capistrano', from:oh-my-zsh
zplug 'plugins/common-aliases', from:oh-my-zsh
zplug 'plugins/docker', from:oh-my-zsh
zplug 'plugins/encode64', from:oh-my-zsh
zplug 'plugins/gem', from:oh-my-zsh
zplug 'plugins/gpg-agent', from:oh-my-zsh
zplug 'plugins/git', from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh, defer:2
zplug 'plugins/history', from:oh-my-zsh
zplug 'plugins/node', from:oh-my-zsh
zplug 'plugins/npm', from:oh-my-zsh
zplug 'plugins/osx', from:oh-my-zsh
zplug 'plugins/pip', from:oh-my-zsh
zplug 'plugins/python', from:oh-my-zsh
zplug 'plugins/rails', from:oh-my-zsh
zplug "plugins/rake", from:oh-my-zsh
zplug 'plugins/redis-cli', from:oh-my-zsh
zplug 'plugins/ruby', from:oh-my-zsh
zplug 'plugins/rvm', from:oh-my-zsh
zplug 'plugins/ssh-agent', from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh, defer:2
zplug 'plugins/thor', from:oh-my-zsh
zplug 'plugins/vagrant', from:oh-my-zsh
zplug 'plugins/vi-mode', from:oh-my-zsh
zplug 'plugins/yarn', from:oh-my-zsh
zplug 'plugins/zsh-autosuggestions', from:oh-my-zsh
zplug "plugins/zsh_reload", from:oh-my-zsh
zplug 'nojhan/liquidprompt'

zplug "k4rthik/git-cal", as:command
zplug "djui/alias-tips"
zplug "so-fancy/diff-so-fancy", as:command


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


zplug load --verbose


source /Users/alexg/.rvm/scripts/rvm


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#!/usr/bin/env ruby

require_relative 'init/err_printer'
require_relative 'init/executor'

CONFIG_DIR = '~/.config'

executor = Executor.new
err_printer = ErrPrinter.new(symbol_h: '=')

executor.exec('xcode-select', 'xcode-select --install')
err_printer.print(executor.err_output) unless executor.exit_status.zero?

executor.exec('create .config folder', 'mkdir -p ~/.config')
err_printer.print(executor.err_output) unless executor.exit_status.zero?

executor.exec('create projects folder', 'mkdir -p ~/projects')
err_printer.print(executor.err_output) unless executor.exit_status.zero?

command =<<-CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        ln -s $DOTFILES/Brewfile          $HOME/Brewfile
        ln -s $DOTFILES/.gitignore-system $HOME/.gitignore-system
        ln -s $DOTFILES/.gitconfig        $HOME/.gitconfig
        ln -s $DOTFILES/.tmux.conf        $HOME/.tmux.conf
        ln -s $DOTFILES/.tmux.osx.conf    $HOME/.tmux.osx.conf
        ln -s $DOTFILES/.tmux.linux.conf  $HOME/.tmux.linux.conf
        ln -s $DOTFILES/.vimrc            $HOME/.vimrc
        ln -s $DOTFILES/.zshrc            $HOME/.zshrc
        ln -s $DOTFILES/.doom.d           $CONFIG_DIR/doom
        ln -s $DOTFILES/.starship.toml    $CONFIG_DIR/starship.toml
        ln -s $DOTFILES/.gitconfig_delta  $HOME/.gitconfig_delta
        ln -s $DOTFILES/sheldon           $CONFIG_DIR/sheldon
CMD

executor.exec('link dotfiles', command)
err_printer.print(executor.err_output) unless executor.exit_status.zero?

executor.exec('Installing brew bundle...', 'brew bundle install -vd')
err_printer.print(executor.err_output) unless executor.exit_status.zero?

command =<<-CMD
        defaults write com.apple.dock springboard-columns -int 10
        defaults write com.apple.dock springboard-rows -int 7
        killall Dock
CMD

executor.exec('mac settings', command)
err_printer.print(executor.err_output) unless executor.exit_status.zero?

executor.exec('init sheldon', 'sheldon lock')
err_printer.print(executor.err_output) unless executor.exit_status.zero?

command =<<-CMD
        git clone --depth 1 https://github.com/doomemacs/doomemacs #{CONFIG_DIR}/emacs
        #{CONFIG_DIR}/emacs/bin/doom install
CMD

executor.exec('install doom emacs', command)
err_printer.print(executor.err_output) unless executor.exit_status.zero?

executor.exec('emacs icon', 'ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications')
err_printer.print(executor.err_output) unless executor.exit_status.zero?

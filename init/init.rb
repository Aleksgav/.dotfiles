#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'

require_relative 'command_install'

CONFIG_DIR = '~/.config'

install = Init::CLI::Commands::Install.new do |executor|
  executor.register do |register|
    register.command('xcode-select', 'xcode-select --install')

    register.command_group('create folders') do |group|
      group.command('create .config folder', 'mkdir -p ~/.config')
      group.command('create projects folder', 'mkdir -p ~/projects')
    end

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
    register.command('link dotfiles', command)

    register.command('Installing brew bundle...', 'brew bundle install -v')

    command =<<-CMD
            defaults write com.apple.dock springboard-columns -int 10
            defaults write com.apple.dock springboard-rows -int 7

            defaults write com.apple.Dock autohide 1

            killall Dock
    CMD
    register.command('mac settings', command)
    register.command('init sheldon', 'sheldon lock')

    register.command_group('doom emacs') do |group|
      command =<<-CMD
              git clone --depth 1 https://github.com/doomemacs/doomemacs #{CONFIG_DIR}/emacs
              #{CONFIG_DIR}/emacs/bin/doom install
      CMD
      group.command('install doom emacs', command)
      group.command('emacs icon', 'ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications')
    end
  end
end

Init::CLI::Commands.register 'install', install, aliases: ['i']

Dry::CLI.new(Init::CLI::Commands).call

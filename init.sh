#!/bin/bash

export DOTFILES=$HOME/.dotfiles

ln -s $DOTFILES/Brewfile $HOME/Brewfile
ln -s $DOTFILES/.gitignore-system $HOME/.gitignore-system
ln -s $DOTFILES/.gitconfig   $HOME/.gitconfig
ln -s $DOTFILES/.tmux.conf   $HOME/.tmux.conf
ln -s $DOTFILES/.vimrc       $HOME/.vimrc
ln -s $DOTFILES/.zshrc       $HOME/.zshrc
ln -s $DOTFILES/.doom.d      $HOME/.doom.d
ln -s $DOTFILES/.starship.toml $HOME/.starship.toml

# set up macos settings
defaults write com.apple.dock springboard-columns -int 10
defaults write com.apple.dock springboard-rows -int 7
killall Dock


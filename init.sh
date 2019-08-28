#!/bin/bash

export DOTFILES=$HOME/.dotfiles

ln -s $DOTFILES/.tmux.conf   $HOME/.tmux.conf
ln -s $DOTFILES/.vimrc       $HOME/.vimrc


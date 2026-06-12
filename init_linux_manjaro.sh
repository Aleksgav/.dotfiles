#!/usr/bin/env sh

echo "Installing Manjaro additons"

echo "Installing make"
pamac install make --no-confirm

echo "Installing autoconf"
pamac install autoconf --no-confirm

echo "Install mise"
curl https://mise.run/bash | sh

export PATH="$HOME/.local/bin:$PATH"

mise trust
mise settings ruby.compile=false
mise use -g ruby@3.4.9

eval "$(mise activate bash --shims)"

cd ~/.dotfiles/init

echo "Installing gems..."
bundle install

echo "Running main installation script..."
./init.rb manjaro

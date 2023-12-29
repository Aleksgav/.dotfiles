#!/usr/bin/env sh

echo "Installing Manjaro additons"

echo "Installing make"
pamac install make

echo "Installing autoconf"
pamac install autoconf

echo "Adding RVM keys"
gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

echo "Installing RVM"
\curl -sSL https://get.rvm.io | bash

source ~/.rvm/scripts/rvm

echo "Installing ruby"
rvm get head
rvm install 3.2 --default

cd ~/.dotfiles/init

echo "Installing gems..."
bundle install

echo "Running main installation script..."
./init.rb manjaro

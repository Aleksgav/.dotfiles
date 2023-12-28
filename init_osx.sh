#!/usr/bin/env sh

echo "Install OSX additions"

echo "Installing Homebrew..."
/bin/bash -c "$(sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing GPG..."
brew install gpg

echo "Installing Git..."
brew install git

echo "Installing RVM"
echo "Installing GPG keys..."
gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
echo "Installing RVM..."
\curl -sSL https://get.rvm.io | bash -s stable --ruby

source ~/.rvm/scripts/rvm

cd ~

echo "Clonning .dotfiles..."
git clone https://github.com/Aleksgav/.dotfiles.git

cd .dotfiles

cd init

echo "Installing gems..."
bundle install

echo "Running main installation script..."
./init.rb i --dry-run

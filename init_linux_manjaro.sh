#!/usr/bin/env sh

echo "Installing Manjaro additons"

echo "Installing make"
pamac install make --no-confirm

echo "Installing autoconf"
pamac install autoconf --no-confirm

echo "Install mise"
curl https://mise.run/bash | sh

export PATH="$HOME/.local/bin:$PATH"

# Put the pinned toolchain config in place BEFORE installing anything, so mise
# reads versions and settings (ruby = 3.4.9, ruby.compile = false) from the
# repo's single source of truth. init.rb re-links this idempotently later.
mkdir -p "$HOME/.config"
ln -sfn "$HOME/.dotfiles/mise" "$HOME/.config/mise"

mise trust
mise install ruby # version + settings come from mise/config.toml

eval "$(mise activate bash --shims)"

cd ~/.dotfiles/init

echo "Installing gems..."
bundle install

echo "Running main installation script..."
./init.rb manjaro

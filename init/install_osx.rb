# frozen_string_literal: true

require_relative 'consts'
require_relative 'command_install'

INSTALL_OSX = Init::CLI::Commands::Install.new do |executor|
  executor.register do |register|
    register.command_group('Create folders') do |group|
      group.command('create .config folder', "mkdir -p #{CONFIG_DIR}")
      group.command('create projects folder', "mkdir -p #{PROJECTS_DIR}")
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
            ln -s $DOTFILES/tmx               /usr/local/bin/tmx
            ln -s $DOTFILES/.gemrc            $HOME/.gemrc
            ln -s $DOTFILES/.vimrc            $HOME/.vimrc
            ln -s $DOTFILES/.zshrc            $HOME/.zshrc
            ln -s $DOTFILES/.doom.d           $CONFIG_DIR/doom
            ln -s $DOTFILES/starship.toml     $CONFIG_DIR/starship.toml
            ln -s $DOTFILES/.gitconfig_delta  $HOME/.gitconfig_delta
            ln -s $DOTFILES/sheldon           $CONFIG_DIR/sheldon
            ln -s $DOTFILES/sketchybar        $CONFIG_DIR/sketchybar
            ln -s $DOTFILES/skhd              $CONFIG_DIR/skhd
            ln -s $DOTFILES/yabai             $CONFIG_DIR/yabai
            ln -s $DOTFILES/alacritty         $CONFIG_DIR/alacritty
            ln -s $DOTFILES/zellij            $CONFIG_DIR/zellij
    CMD
    register.command('link dotfiles', command)

    register.command('installing brew bundle...', 'brew bundle install -v')

    register.command_group('Mac settings') do |group|
      group.command('set columns on board', 'defaults write com.apple.dock springboard-columns -int 10')
      group.command('set rows on board', 'defaults write com.apple.dock springboard-rows -int 7')
      group.command('set dock autohide', 'defaults write com.apple.Dock autohide 1')
      group.command('restart dock', 'killall Dock')

      group.command('disable all finder animations', 'defaults write com.apple.finder DisableAllAnimations -bool true')
      group.command('restart finder', 'killall Finder')
    end

    register.command('init sheldon', 'sheldon lock')

    register.command('init tmux plugin manager', 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm')

    register.command_group('Doom emacs') do |group|
      group.command('clone doom emacs', "git clone --depth 1 https://github.com/doomemacs/doomemacs #{CONFIG_DIR}/emacs")
      group.command('install doom emacs', "#{CONFIG_DIR}/emacs/bin/doom install")
      group.command('emacs icon', 'ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications')
    end

    register.command_group('Ruby toolchain') do |group|
      group.command('ruby language server', 'gem install solargraph')
      group.command('static code analyser', 'gem install rubocop')
    end

    register.command_group('Node toolchain') do |group|
      group.command('js beautify', 'npm -g install js-beautify')
    end

    register.command_group('Rust toolchain') do |group|
      group.command('rust installation', "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh")
      group.command('add nigthly', 'rustup install nightly')
      group.command('add clippy', 'cargo +nightly install clippy')
      group.command('cargo audit', 'cargo install cargo-audit')
      group.command('cargo deny', 'cargo install cargo-deny')
      group.command('cargo edit', 'cargo install cargo-edit')
      group.command('cargo expand', 'cargo install cargo-expand')
      group.command('cargo tarpaulin', 'cargo install cargo-tarpaulin')
      group.command('cargo udeps', 'cargo install cargo-udeps --locked')
      group.command('cargo watch', 'cargo install cargo-watch')
    end

    register.command_group('Golang toolchain') do |group|
      group.command('golang version manager', 'bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)')
      group.command('golang installing', 'gvm install go1.20.4 --with-protobuf')
      group.command('set default golang version', 'gvm use 1.20.4 --default')
    end
  end
end
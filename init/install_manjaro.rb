# frozen_string_literal: true

require_relative 'consts'
require_relative 'command_install'

INSTALL_MANJARO = Init::CLI::Commands::Install.new do |executor|
  executor.register do |register|
    register.command_group('Create folders') do |group|
      group.command('create .config folder', "mkdir -p #{CONFIG_DIR}")
      group.command('create projects folder', "mkdir -p #{PROJECTS_DIR}")
    end

    command =<<-CMD
            export DOTFILES=$HOME/.dotfiles
            export CONFIG_DIR=#{CONFIG_DIR}

            ln -s $DOTFILES/.gitignore-system $HOME/.gitignore-system
            ln -s $DOTFILES/.gitconfig        $HOME/.gitconfig
            ln -s $DOTFILES/.tmux.conf        $HOME/.tmux.conf
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

    register.command_group('Manjaro settings') do |group|
      group.command('Flatpack plugin', 'pamac install libpamac-flatpak-plugin')
      group.command('Snap plugin', 'pamac install libpamac-snap-plugin')
    end

    register.command_group('Fonts') do |group|
      group.command('ttf-fira-code', 'pamac install ttf-fira-code --no-confirm')
      group.command('ttf-firacode-nerd', 'pamac install ttf-firacode-nerd --no-confirm')
      group.command('ttf-hack-nerd', 'pamac install ttf-hack-nerd --no-confirm')
    end

    register.command_group('Dev tools') do |group|
      group.command('Autoconf', 'pamac install autoconf --no-confirm')
      group.command('Automake', 'pamac install automake --no-confirm')
      group.command('make', 'pamac install make --no-confirm')
      group.command('cmake', 'pamac install cmake --no-confirm')
      group.command('coreutils', 'pamac install coreutils --no-confirm')
      group.command('gcc', 'pamac install gcc --no-confirm')
      group.command('gdb', 'pamac install gdb --no-confirm')
      group.command('gnupg', 'pamac install gnupg --no-confirm')
    end

    register.command_group('Libs') do |group|
      group.command('imagemagick', 'pamac install imagemagick --no-confirm')
      group.command('jemalloc', 'pamac install jemalloc --no-confirm')
      group.command('libyaml', 'pamac install libyaml --no-confirm')
      group.command('ncurses', 'pamac install ncurses --no-confirm')
      group.command('readline', 'pamac install readline --no-confirm')
      group.command('zlib', 'pamac install zlib --no-confirm')
      group.command('cairo', 'pamac install cairo --no-confirm')
      group.command('harfbuzz', 'pamac install harfbuzz --no-confirm')
      group.command('pango', 'pamac install pango --no-confirm')
    end

    register.command_group('Rust & toolchain') do |group|
      group.command('rust installation', "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y")
      group.command('reload bash', 'source ~/.bashrc')
      group.command('add nigthly', 'rustup install nightly')
      group.command('add clippy', 'cargo +nightly install clippy')
      group.command('cargo audit', 'cargo install cargo-audit')
      group.command('cargo deny', 'cargo install cargo-deny')
      group.command('cargo edit', 'cargo install cargo-edit')
      group.command('cargo expand', 'cargo install cargo-expand')
      group.command('cargo tarpaulin', 'cargo install cargo-tarpaulin')
      group.command('cargo udeps', 'cargo install cargo-udeps --locked')
      group.command('cargo watch', 'cargo install cargo-watch')
      group.command('rust analyzer', 'pamac install rust-analyzer')
    end

    register.command_group('Golang & toolchain') do |group|
      group.command('golang', 'pamac install go --no-confirm')
      group.command('golang version manager', 'bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)')
      group.command('golang installing', 'gvm install go1.20.4 --with-protobuf')
      group.command('set default golang version', 'gvm use 1.20.4 --default')
      group.command('golangci-lint', 'snap install golangci-lint --no-confirm')
      group.command('gopls', 'pamac install gopls --no-confirm')
      #
      # gomodifytags
      # gotests
    end

    register.command_group('Asm') do |group|
      group.command('nasm', 'pamac install nasm')
    end

    register.command_group('Lua & tools') do |group|
      group.command('lua', 'pamac install lua')
      group.command('luajit', 'pamac install luajit')
      group.command('luarocks', 'pamac install luarocks')
    end

    register.command_group('Python') do |group|
      group.command('python', 'pamac install python')
    end

    register.command_group('Ruby toolchain') do |group|
      group.command('ruby language server', 'gem install solargraph')
      group.command('static code analyser', 'gem install rubocop')
    end

    register.command_group('Node & toolchain') do |group|
      group.command('nodejs', 'pamac install nodejs')
      group.command('yarn', 'pamac install yarn')
      group.command('stylelint', 'pamac install stylelint')
      group.command('js beautify', 'npm -g install js-beautify')
    end

    register.command_group('CL') do |group|
      group.command('sbcl', 'pamac install sbcl')
    end

    register.command_group('JDK') do |group|
      group.command('jdk-openjdk', 'pamac install jdk-openjdk')
    end

    register.command_group('Ansible & tools') do |group|
      group.command('Ansible', 'pamac install ansible')
      group.command('Ansible Language Server', 'pamac install ansible-language-server')
      group.command('Ansible lint', 'pamac install ansible-lint')
    end

    register.command_group('Terraform & tools') do |group|
      group.command('terraform', 'pamac install terraform')
      # terrafrom-ls
    end

    register.command_group('GRPC & tools') do |group|
      group.command('buf', 'pamac install buf')
      group.command('grpc', 'pamac install grpc')
      group.command('protobuf', 'pamac install protobuf')
      group.command('protoc-gen-go', 'go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28')
      group.command('protoc-gen-go-grpc', 'go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2')
    end

    register.command_group('Haskell') do |group|
      group.command('cabal-install', 'pamac install cabal-install')
      group.command('ghc', 'pamac install ghc')
      group.command('haskell-language-server', 'pamac install haskell-language-server')
      group.command('haskell-stack', 'pamac install stack')
    end

    register.command_group('Git tools') do |group|
      group.command('git', 'pamac install git')
      group.command('git-delta', 'pamac install git-delta')
      group.command('gitui', 'pamac install gitui')
      group.command('tig', 'pamac install tig')
      # git-cal
    end

    register.command_group('CLI tools') do |group|
      group.command('bat', 'pamac install bat')
      group.command('btop', 'pamac install btop')
      group.command('cloc', 'pamac install cloc')
      group.command('direnv', 'pamac install direnv')
      group.command('diff-so-fancy', 'pamac install diff-so-fancy')
      group.command('htop', 'pamac install htop')
      group.command('httpie', 'pamac install httpie')
      group.command('curlie', 'pamac install curlie')
      group.command('fd', 'pamac install fd')
      group.command('fzf', 'pamac install fzf')
      group.command('figlet', 'pamac install figlet')
      group.command('mc', 'pamac install mc')
      group.command('jq', 'pamac install jq')
      group.command('ripgrep', 'pamac install ripgrep')
      group.command('tldr', 'pamac install tldr')
      group.command('tealdeer', 'pamac install tealdeer')
      group.command('tmux', 'pamac install tmux')
      group.command('tree', 'pamac install tree')
      group.command('tokei', 'pamac install tokei')
      group.command('unzip', 'pamac install unzip')
      group.command('wget', 'pamac install wget')
      group.command('xsel', 'pamac install xsel')
      group.command('zellij', 'pamac install zellij')
      group.command('zenith', 'pamac install zenith')
      group.command('alacritty', 'pamac install alacritty')
      group.command('k9s', 'pamac install k9s')
      group.command('task', 'pamac install task')
      group.command('taskwarrior-tui', 'pamac install taskwarrior-tui')
      group.command('timewarrior', 'pamac install timewarrior')
      group.command('unrar', 'pamac install unrar')
      group.command('gotop', 'span install gotop')
      group.command('kubectl', 'pamac install kubtctl')
      group.command('aspell', 'pamac install aspell')
    end

    register.command_group('Docker & tools') do |group|
      group.command('docker', 'pamac install docker')
      group.command('docker-compose', 'pamac install docker-compose')
    end

    register.command_group('Editors & tools') do |group|
      group.command('neovim', 'pamac install neovim')
      group.command('editorconfig-checker', 'pamac install editorconfig-checker')
      group.command('tree-sitter', 'pamac install tree-sitter')
      # editorconfig
    end

    register.command_group('Doom emacs') do |group|
      group.command('emacs-nativecomp', 'pamac install emacs-nativecomp')
      group.command('clone doom emacs', "git clone --depth 1 https://github.com/doomemacs/doomemacs #{CONFIG_DIR}/emacs")
      group.command('install doom emacs', "#{CONFIG_DIR}/emacs/bin/doom install")
    end

    register.command_group('Servers') do |group|
      group.command('postgresql', 'pamac install postgresql')
      group.command('rabbitmq', 'pamac install rabbitmq')

      group.command('redis', 'pamac install redis')
      group.command('redisinsight', 'pamac install redisinsight')

      group.command('sqlite', 'pamac install sqlite')

      group.command('tarantool', 'pamac install tarantool')
      group.command('cartridge-cli', 'pamac install cartridge-cli')
    end

    register.command_group('GUI apps') do |group|
      group.command('google-chrome', 'pamac install google-chrome')
      group.command('opera', 'pamac install opera')
      group.command('notion', 'pamac install notion')
      group.command('telegram-desktop', 'pamac install telegram-desktop')
      group.command('vlc', 'pamac install vlc')
      group.command('zeplin', 'snap install zeplin')
      group.command('zoom', 'snap install zoom-client')
      group.command('home-assistant', 'pamac install home-assistant')
      group.command('discord', 'pamac install discord')
      group.command('ghidra', 'pamac install ghidra')
      # via
    end

    register.command_group('Other') do |group|
      group.command('python-pygments', 'pamac install python-pygments')
      group.command('gobang', 'cargo install --version 0.1.0-alpha.5 gobang')
      group.command('postman', 'snap install postman')
      group.command('skype', 'snap install skype')
      group.command('sublime-text', 'snap install sublime-text')
      group.command('Outline client', 'snap install outline-client --edge --devmode')
      # chromedriver
      # graphql-playground
    end

    register.command_group('Shell') do |group|
      group.command('zsh', 'pamac install zsh')
      group.command('shellcheck', 'pamac install shellcheck')
      group.command('nushell', 'pamac install nushell')
      group.command('zsh-syntax-highlighting', 'pamac install zsh-syntax-highlighting')
      group.command('sheldon', 'pamac install sheldon')
      group.command('starship', 'pamac install starship')
    end

    register.command('init sheldon', 'sheldon lock')

    register.command('init tmux plugin manager', 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm')

    register.command_group('Virtualization') do |group|
      group.command('virtualbox', 'pamac install virtualbox')
      group.command('virtualbox guest utils', 'pamac install virtualbox-guest-utils')
    end
  end
end

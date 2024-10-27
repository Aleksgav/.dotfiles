# frozen_string_literal: true

MnjPkg = Linux::Manjaro

ManjaroMain = Packager::Installation.new do
  group('Create folders') do
    package MnjPkg::ConfigFolder
    package MnjPkg::ConfigAutostartFolder
    package MnjPkg::ProjectsFolder
  end

  group('Manjaro settings') do
    package MnjPkg::SnapPlugin
    package MnjPkg::FlatpakPlugin
    package MnjPkg::Appimagelauncher

    # NOTE temporary disable
    # package MnjPkg::ZshDefault
  end

  # TODO или .zshrc не слинковался или перезатерся
  # TODO не установил почтовые программы и тд
  # TODO snap установка не работает как нужно
  package MnjPkg::LinkDotfiles

  group('Fonts') do
    package MnjPkg::FontTtfFiraCode
    package MnjPkg::FontTtfFiracodeNerd
    package MnjPkg::FontTtfFiraSans
    package MnjPkg::FontTtfHackNerd
    package MnjPkg::FontOtfFiramonoNerd
    package MnjPkg::FontTtfNotoNerd
    package MnjPkg::FontNotoEmoji
  end

  group('Dev tools') do
    package MnjPkg::BaseDevel
  end

  group('Libs') do
    package MnjPkg::LibImagemagic
    package MnjPkg::LibJemalloc
    package MnjPkg::LibNcurses
    package MnjPkg::LibReadline
    package MnjPkg::LibZlib
    package MnjPkg::LibCairo
    package MnjPkg::LibHarfbuzz
    package MnjPkg::LibPango
    package MnjPkg::Poppler
  end

  group('Rust & toolchain') do
    package MnjPkg::RustLangRustup
    package MnjPkg::ReloadCargo
    package MnjPkg::RustupAddNightly
    package MnjPkg::RustupAddClippy
    package MnjPkg::RustupAddRustAnalyser
    package MnjPkg::CargoAudit
    package MnjPkg::CargoDeny
    package MnjPkg::CargoEdit
    package MnjPkg::CargoExpand
    package MnjPkg::CargoTarpaulin
    package MnjPkg::CargoUdeps
    package MnjPkg::CargoWatch
  end

  group('Golang & toolchain') do
    package MnjPkg::Golang
    package MnjPkg::Gvm
    package MnjPkg::ReloadBash
    package MnjPkg::Go1204Gvm
    package MnjPkg::Go1204GvmDefault
    package MnjPkg::GolangcilintSnap
    package MnjPkg::Gopls

    # NOTE temporary disable
    # gomodifytags
    # gotests
  end

  group('Asm') do
    package MnjPkg::Nasm
  end

  group('Lua & tools') do
    package MnjPkg::Lua
    package MnjPkg::LuaJit
    package MnjPkg::LuaRocks
  end

  group('Python') do
    package MnjPkg::Python
  end

  group('Ruby toolchain') do
    package MnjPkg::RubySolargraph
    package MnjPkg::RubyRubocop
  end

  group('Node & toolchain') do
    package MnjPkg::Nodejs
    package MnjPkg::Yarn
    package MnjPkg::Stylelint
    package MnjPkg::JsBeautify
  end

  group('CL') do
    package MnjPkg::CommonLisp
  end

  group('JDK') do
    package MnjPkg::OpenJdk
  end

  group('GRPC & tools') do
    package MnjPkg::Buf
    package MnjPkg::Grpc
    package MnjPkg::Protobuf
    package MnjPkg::ProtocGenGo
    package MnjPkg::ProtocGenGoGrpc
  end

  group('Haskell & tools') do
    package MnjPkg::CabalInstall
    package MnjPkg::Ghc
    package MnjPkg::HaskellLanguageServer

    # NOTE temporary disable
    # group.command('haskell-stack', 'pamac install stack --no-confirm')
  end

  group('Ansible & tools') do
    package MnjPkg::Ansible
    package MnjPkg::AnsibleLanguageServer
    package MnjPkg::AnsibleLint
  end

  group('Terraform & tools') do
    package MnjPkg::Terraform
    # terrafrom-ls
  end

  group('Git & tools') do
    package MnjPkg::Git
    package MnjPkg::GitDelta
    package MnjPkg::GitUi
    package MnjPkg::Tig
    package MnjPkg::PreCommit

    # git-cal
  end

  group('CLI tools') do
    package MnjPkg::Bat
    package MnjPkg::Btop
    package MnjPkg::Bottom
    package MnjPkg::Xclip
    package MnjPkg::Cloc
    package MnjPkg::Direnv
    package MnjPkg::DiffSoFancy
    package MnjPkg::Htop
    package MnjPkg::Httpie
    package MnjPkg::Curlie
    package MnjPkg::Fd
    package MnjPkg::Fzf
    package MnjPkg::Figlet
    package MnjPkg::Mc
    package MnjPkg::Jq
    package MnjPkg::Ripgrep
    package MnjPkg::Tldr
    package MnjPkg::Tealdeer
    package MnjPkg::Tmux
    package MnjPkg::Tree
    package MnjPkg::Tokei
    package MnjPkg::Unzip
    package MnjPkg::Wget
    package MnjPkg::Xsel
    package MnjPkg::Zellij
    package MnjPkg::Zenith
    package MnjPkg::Alacritty
    package MnjPkg::K9s
    package MnjPkg::Task
    package MnjPkg::Timewarrior
    package MnjPkg::TaskwarriorTui
    package MnjPkg::Unrar
    package MnjPkg::Gotop
    package MnjPkg::Kubectl
    package MnjPkg::Aspell
    package MnjPkg::Glow
    package MnjPkg::Bandwhich
    package MnjPkg::Kmon
    package MnjPkg::Xplr
    package MnjPkg::GpgTui
    package MnjPkg::OutlineClientCli
    package MnjPkg::Isync
    package MnjPkg::Mu
    package MnjPkg::Syncthing
    # package MnjPkg::LxqtPolicykit
    package MnjPkg::Ffmpegthumbnailer
    package MnjPkg::P7zip
    package MnjPkg::Zoxide
    package MnjPkg::Yazi
    package MnjPkg::Cmus
    package MnjPkg::Lazygit
    package MnjPkg::Nnn
    package MnjPkg::Superfile
  end

  group('Docker & tools') do
    package MnjPkg::Docker
    package MnjPkg::DockerCompose
  end

  group('Editors tools') do
    package MnjPkg::EditorconfigChecker
    package MnjPkg::TreeSitter
    package MnjPkg::YamlLanguageServer
    package MnjPkg::BashLanguageServer

    # editorconfig
  end

  group('Vim') do
    package MnjPkg::Neovim
    package MnjPkg::LazyVim
  end

  group('Doom emacs') do
    package MnjPkg::Emacs
    package MnjPkg::DoomEmacs
    package MnjPkg::EmacsDaemon
  end

  group('Window manager') do
    package MnjPkg::Leftwm
    package MnjPkg::LeftwmTheme
    # package MnjPkg::LeftwmThemeAscent
    package MnjPkg::Polybar
    package MnjPkg::Feh
    package MnjPkg::Rofi
    package MnjPkg::Slock
    package MnjPkg::XssLock
    package MnjPkg::Xsecurelock
    package MnjPkg::Xscreensaver
    package MnjPkg::Picom
    package MnjPkg::Dunst
  end

  group('Servers') do
    package MnjPkg::Postgresql
    package MnjPkg::Rabbitmq
    package MnjPkg::Redis
    package MnjPkg::Sqlite
    package MnjPkg::Tarantool
    package MnjPkg::CartridgeCli
  end

  group('GUI apps') do
    package MnjPkg::GoogleChrome
    package MnjPkg::Opera
    package MnjPkg::Notion
    package MnjPkg::TelegramDesktop
    package MnjPkg::Vlc
    package MnjPkg::HomeAssistant
    package MnjPkg::Discord
    package MnjPkg::Ghidra
    package MnjPkg::Flameshot
    package MnjPkg::Zeplin
    package MnjPkg::Zoom
    package MnjPkg::SonicPi
    package MnjPkg::Redisinsight
    package MnjPkg::Postman
    package MnjPkg::Skype
    package MnjPkg::MattermostDesktop

    package MnjPkg::Mplayer
    package MnjPkg::Mpv
    package MnjPkg::Nekoray
    # group.command('Outline client', 'snap install outline-client --edge --devmode')
    # via
    # graphql-playground
  end

  group('Other') do
    package MnjPkg::PythonPygments
    package MnjPkg::Gobang

    package MnjPkg::Conky
    # chromedriver
  end

  group('Shell') do
    package MnjPkg::Zsh
    package MnjPkg::Shellcheck
    package MnjPkg::Nushell
    package MnjPkg::ZshSyntaxHighliting
    package MnjPkg::Sheldon
    package MnjPkg::Starship
    package MnjPkg::SheldonInit
    package MnjPkg::Tpm
  end

  group('Virtualization') do
    package MnjPkg::Virtualbox
    package MnjPkg::VirtualboxGuestUtils
  end
end

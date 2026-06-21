# frozen_string_literal: true

ArchPkg = Linux::Arch

ArchMain = Packager::Installation.new do
  group('Create folders') do
    package ArchPkg::ConfigFolder
    package ArchPkg::ConfigAutostartFolder
    package ArchPkg::ProjectsFolder
  end

  package ArchPkg::LinkDotfiles

  group('Build prerequisites') do
    package ArchPkg::Git
    package ArchPkg::BaseDevel
    package ArchPkg::Gdb
  end

  group('Fonts') do
    package ArchPkg::FontTtfFiraCode
    package ArchPkg::FontTtfFiracodeNerd
    package ArchPkg::FontTtfFiraSans
    package ArchPkg::FontTtfHackNerd
    package ArchPkg::FontOtfFiramonoNerd
    package ArchPkg::FontTtfNotoNerd
    package ArchPkg::FontNotoEmoji
    package ArchPkg::FontTtfNerdSymbolsMono
  end

  group('Golang & toolchain') do
    package ArchPkg::Golang
    package ArchPkg::Golangcilint
    package ArchPkg::Gopls
  end

  group('Asm') do
    package ArchPkg::Nasm
    package ArchPkg::Fasm
  end

  group('Rust & toolchain') do
    package ArchPkg::RustLangRustup
    package ArchPkg::RustupAddNightly
    package ArchPkg::RustupAddClippy
    package ArchPkg::RustupAddRustAnalyser
    package ArchPkg::CargoAudit
    package ArchPkg::CargoDeny
    package ArchPkg::CargoEdit
    package ArchPkg::CargoExpand
    package ArchPkg::CargoTarpaulin
    package ArchPkg::CargoUdeps
    package ArchPkg::CargoWatch
  end

  group('Lua & tools') do
    package ArchPkg::Lua
    package ArchPkg::LuaJit
    package ArchPkg::LuaRocks
  end

  group('Ruby toolchain') do
    package ArchPkg::RubyGems
    package ArchPkg::RubySolargraph
    package ArchPkg::RubyRubocop
  end

  group('Python') do
    package ArchPkg::Python
    package ArchPkg::PythonPygments
  end

  group('Node & toolchain') do
    package ArchPkg::Nodejs
    package ArchPkg::Yarn
    package ArchPkg::Stylelint
    package ArchPkg::JsBeautify
  end

  group('CL') do
    package ArchPkg::CommonLisp
  end

  group('Haskell & toolchain') do
    package ArchPkg::Ghcup
    package ArchPkg::Ghc
    package ArchPkg::CabalInstall
    package ArchPkg::Stack
    package ArchPkg::HaskellLanguageServer
  end

  group('Zig & toolchain') do
    package ArchPkg::Zig
    package ArchPkg::Zls
  end

  group('JDK') do
    package ArchPkg::OpenJdk
  end

  group('Ansible & tools') do
    package ArchPkg::Ansible
    package ArchPkg::AnsibleLanguageServer
    package ArchPkg::AnsibleLint
  end

  group('Terraform & tools') do
    package ArchPkg::Terraform
    # terrafrom-ls
  end

  group('Git & tools') do
    # NOTE: Git itself (and its config linking) lives in 'Build prerequisites'.
    package ArchPkg::GitDelta
    package ArchPkg::GitUi
    package ArchPkg::Tig
    package ArchPkg::PreCommit

    # git-cal
  end

  # TODO: Postpone
  # group('AUR helper') do
  #   package ArchPkg::Yay
  # end

  group('CLI tools') do
    package ArchPkg::Bat
    package ArchPkg::Btop
    package ArchPkg::Bottom
    package ArchPkg::Xclip
    package ArchPkg::Cloc
    package ArchPkg::Direnv
    package ArchPkg::DiffSoFancy
    package ArchPkg::Dysk
    package ArchPkg::Htop
    package ArchPkg::Httpie
    package ArchPkg::Curlie
    package ArchPkg::Fd
    package ArchPkg::Fzf
    package ArchPkg::Figlet
    package ArchPkg::Mc
    package ArchPkg::Jq
    package ArchPkg::Ripgrep
    package ArchPkg::TimerRs
    package ArchPkg::Tldr
    package ArchPkg::Tealdeer
    package ArchPkg::Tmux
    package ArchPkg::Tree
    package ArchPkg::Tokei
    package ArchPkg::Unzip
    package ArchPkg::Wget
    package ArchPkg::Xsel
    package ArchPkg::Zellij
    package ArchPkg::Zenith
    package ArchPkg::Alacritty
    package ArchPkg::K9s
    package ArchPkg::Task
    package ArchPkg::Timewarrior
    package ArchPkg::TaskwarriorTui
    package ArchPkg::Unrar
    # gotop: AUR-only on Arch (Manjaro uses snap). Enable the Yay group first.
    # package ArchPkg::Gotop
    package ArchPkg::Kubectl
    package ArchPkg::Aspell
    package ArchPkg::Glow
    package ArchPkg::Bandwhich
    package ArchPkg::Kmon
    package ArchPkg::Xplr
    package ArchPkg::GpgTui
    package ArchPkg::Isync
    # mu (maildir-utils): AUR-only on Arch. Enable the Yay group first.
    # package ArchPkg::Mu
    package ArchPkg::Syncthing
    package ArchPkg::Ffmpegthumbnailer
    package ArchPkg::P7zip
    package ArchPkg::Zoxide
    package ArchPkg::Yazi
    package ArchPkg::Cmus
    package ArchPkg::Lazygit
    package ArchPkg::Nnn
    package ArchPkg::Superfile
  end
end

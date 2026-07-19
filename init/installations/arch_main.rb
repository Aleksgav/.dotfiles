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
    package ArchPkg::RebuildFontCache
  end

  group('Dev tools') do
    package ArchPkg::Just
    package ArchPkg::JustLsp
    package ArchPkg::OpenApiTui
  end

  group('Libs') do
    package ArchPkg::LibImagemagic
    package ArchPkg::LibJemalloc
    package ArchPkg::LibVips
    package ArchPkg::Openslide
    package ArchPkg::Sqlite
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

  group('R') do
    package ArchPkg::R
  end

  group('Zig & toolchain') do
    package ArchPkg::Zig
    package ArchPkg::Zls
  end

  group('JDK') do
    package ArchPkg::OpenJdk
  end

  group('GRPC & tools') do
    package ArchPkg::Buf
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

  group('Cloud & infra') do
    package ArchPkg::AwsCliV2
    package ArchPkg::S3cmd
    package ArchPkg::Minikube
    package ArchPkg::Helm
    package ArchPkg::Packer
    package ArchPkg::Certbot
  end

  group('Secrets & security') do
    package ArchPkg::Age
    package ArchPkg::Pass
    package ArchPkg::Gitleaks
  end

  group('YubiKey') do
    package ArchPkg::YubikeyManager
    package ArchPkg::YubikeyPersonalizationGui
  end

  group('Security & pentesting') do
    package ArchPkg::Zaproxy
    package ArchPkg::Gobuster
    package ArchPkg::Hydra
    package ArchPkg::Nmap
    package ArchPkg::Masscan
    # Radare2 before Ghidra: Ghidra's post_install runs `r2pm` (ships with radare2).
    package ArchPkg::Radare2
    package ArchPkg::Ghidra
  end

  group('Git & tools') do
    # NOTE: Git itself (and its config linking) lives in 'Build prerequisites'.
    package ArchPkg::GitDelta
    package ArchPkg::GitUi
    package ArchPkg::Tig
    package ArchPkg::PreCommit
    package ArchPkg::GithubCli

    # git-cal
  end

  group('AUR helper') do
    package ArchPkg::Yay
  end

  group('System & hardware') do
    package ArchPkg::LocaleRu
    package ArchPkg::LinuxHeaders
    package ArchPkg::DbusBroker
    package ArchPkg::Openssh
    package ArchPkg::Rtkit
    package ArchPkg::IntelUcode
    package ArchPkg::Fuse2
    package ArchPkg::Lshw
    package ArchPkg::Powertop
    package ArchPkg::Inxi
    package ArchPkg::Acpi
    package ArchPkg::Dialog
    package ArchPkg::Reflector
    package ArchPkg::PacmanContrib
    package ArchPkg::Fstrim
    package ArchPkg::Smartmontools
    package ArchPkg::Gparted
    package ArchPkg::Udisks2
    package ArchPkg::Udiskie
    package ArchPkg::Gvfs
    package ArchPkg::Dosfstools
    package ArchPkg::Exfatprogs
    package ArchPkg::Ntfs3g
    package ArchPkg::Usbutils
    package ArchPkg::AppleMagicTrackpad
  end

  group('Graphics') do
    # lib32-* live in [multilib]; enable + refresh it before they install.
    package ArchPkg::EnableMultilib
    package ArchPkg::Mesa
    package ArchPkg::VulkanIntel
    package ArchPkg::Lib32Mesa
    package ArchPkg::Lib32VulkanIntel
    package ArchPkg::VulkanTools
    package ArchPkg::MesaUtils
  end

  group('Network tools') do
    package ArchPkg::Iw
    package ArchPkg::WpaSupplicant
    package ArchPkg::Tcpdump
    package ArchPkg::WiresharkQt
    package ArchPkg::Mtr
    package ArchPkg::Traceroute
    package ArchPkg::NetTools
    package ArchPkg::ConntrackTools
    package ArchPkg::Ethtool
    package ArchPkg::Rsync
    package ArchPkg::Socat
    package ArchPkg::Websocat
    package ArchPkg::OpenbsdNetcat
    package ArchPkg::Axel
    package ArchPkg::Bind
    package ArchPkg::Whois
    package ArchPkg::NmConnectionEditor
    package ArchPkg::NetworkManagerApplet
    package ArchPkg::Openvpn
    package ArchPkg::NetworkmanagerOpenvpn
    package ArchPkg::WireguardTools
    package ArchPkg::Netbird
    package ArchPkg::NetbirdUi
    # NetBird self-hosted server: single binary providing management, signal & relay.
    package ArchPkg::NetbirdServer
  end

  group('Audio') do
    package ArchPkg::AudioFirmware
    package ArchPkg::Alsa
    package ArchPkg::Pipewire
    package ArchPkg::Wireplumber
    package ArchPkg::Pavucontrol
    package ArchPkg::Wiremix
  end

  group('Bluetooth') do
    package ArchPkg::Bluez
    package ArchPkg::BluezUtils
    package ArchPkg::Blueman
    package ArchPkg::Bluetui
  end

  group('Printing') do
    package ArchPkg::Cups
    package ArchPkg::CupsFilters
    package ArchPkg::CupsPdf
    package ArchPkg::SystemConfigPrinter
  end

  # Only for laptops
  group('Laptop', chassis: :laptop) do
    package ArchPkg::Tlp
    package ArchPkg::TlpRdw
    package ArchPkg::Brightnessctl
  end

  group('Shell') do
    package ArchPkg::Zsh
    package ArchPkg::BashCompletion
    package ArchPkg::Shellcheck
    package ArchPkg::Nushell
    package ArchPkg::ZshSyntaxHighliting
    package ArchPkg::Sheldon
    package ArchPkg::Starship
  end

  group('CLI tools') do
    package ArchPkg::Bat
    package ArchPkg::Btop
    package ArchPkg::Bottom
    package ArchPkg::Cloc
    package ArchPkg::Direnv
    package ArchPkg::DiffSoFancy
    package ArchPkg::Dysk
    package ArchPkg::Htop
    package ArchPkg::Httpie
    package ArchPkg::Pgcli
    package ArchPkg::Curlie
    package ArchPkg::Fd
    package ArchPkg::Fzf
    package ArchPkg::Figlet
    package ArchPkg::Mc
    package ArchPkg::Jq
    package ArchPkg::Yq
    package ArchPkg::Ripgrep
    package ArchPkg::TimerRs
    package ArchPkg::Tealdeer
    package ArchPkg::Tmux
    package ArchPkg::Tpm
    package ArchPkg::Tree
    package ArchPkg::Tokei
    package ArchPkg::Unzip
    package ArchPkg::Zip
    package ArchPkg::Less
    package ArchPkg::Wget
    package ArchPkg::Thunar
    package ArchPkg::Zellij
    package ArchPkg::Zenith
    package ArchPkg::Alacritty
    package ArchPkg::K9s
    package ArchPkg::Task
    package ArchPkg::Timewarrior
    package ArchPkg::TaskwarriorTui
    package ArchPkg::Unrar
    package ArchPkg::Kubectl
    package ArchPkg::Aspell
    package ArchPkg::Glow
    package ArchPkg::Bandwhich
    package ArchPkg::Kmon
    package ArchPkg::Xplr
    package ArchPkg::GpgTui
    package ArchPkg::Isync
    package ArchPkg::Mu
    package ArchPkg::Syncthing
    package ArchPkg::Ffmpegthumbnailer
    package ArchPkg::P7zip
    package ArchPkg::Zoxide
    package ArchPkg::Yazi
    package ArchPkg::Cmus
    package ArchPkg::Lazygit
    package ArchPkg::Nnn
    package ArchPkg::Superfile
    package ArchPkg::Chafa
    package ArchPkg::Dust
    package ArchPkg::DuaCli
    package ArchPkg::Ncdu
    package ArchPkg::Fastfetch
    package ArchPkg::Neofetch
    package ArchPkg::Systeroid
    package ArchPkg::Testdisk
    package ArchPkg::Himalaya
    package ArchPkg::MatchaClient
    package ArchPkg::YtDlp
  end

  group('Docker & tools') do
    package ArchPkg::Docker
    package ArchPkg::DockerCompose
    package ArchPkg::DockerBuildx
  end

  group('AI coding agents') do
    package ArchPkg::Crush
    package ArchPkg::Forgecode
    package ArchPkg::ClaudeCode
  end

  group('Editors tools') do
    package ArchPkg::EditorconfigChecker
    package ArchPkg::TreeSitter
    package ArchPkg::TreeSitterCli
    package ArchPkg::YamlLanguageServer
    package ArchPkg::BashLanguageServer

    # editorconfig
  end

  group('Vim') do
    package ArchPkg::Neovim
  end

  group('Doom emacs') do
    package ArchPkg::Emacs
    package ArchPkg::DoomEmacs
  end

  group('App launchers') do
    package ArchPkg::Appimagelauncher
  end

  group('Wayland compositor & env') do
    package ArchPkg::XdgDesktopPortal
    package ArchPkg::XdgDesktopPortalWlr
    package ArchPkg::XdgDesktopPortalGtk
    package ArchPkg::Mangowm
    package ArchPkg::Swaybg
    package ArchPkg::Waybar
    package ArchPkg::Wlogout
    package ArchPkg::Fuzzel
    package ArchPkg::Tofi
    package ArchPkg::Wdisplays
    package ArchPkg::WlrRandr
    package ArchPkg::WlClipboard
    package ArchPkg::SwayNotificationCenter
    package ArchPkg::Hyprlock
    package ArchPkg::Hypridle
    package ArchPkg::Hyprpolkitagent
    package ArchPkg::Kanshi
    package ArchPkg::Grim
    package ArchPkg::Slurp
    package ArchPkg::Satty
  end

  group('Login & session manager') do
    # uwsm before greetd: greetd's config launches the session via `uwsm start`.
    package ArchPkg::Uwsm
    # greetd before tuigreet: greetd creates the `greeter` user that tuigreet's cache-dir step (and the greeter UI) run as.
    package ArchPkg::Greetd
    package ArchPkg::Tuigreet
  end

  group('GUI apps') do
    package ArchPkg::GoogleChrome
    package ArchPkg::Opera
    # package ArchPkg::Notion
    package ArchPkg::TelegramDesktop
    package ArchPkg::Vlc
    # package ArchPkg::HomeAssistant
    # package ArchPkg::Discord
    # package ArchPkg::Zeplin
    package ArchPkg::Zoom
    # package ArchPkg::SonicPi
    package ArchPkg::Redisinsight
    package ArchPkg::Postman
    # package ArchPkg::MattermostDesktop
    package ArchPkg::Mpv
    package ArchPkg::Imv
    package ArchPkg::Throne
    package ArchPkg::Sioyek
    package ArchPkg::Gitbutler
    package ArchPkg::Vial
    package ArchPkg::Firefox
    package ArchPkg::Anki
    package ArchPkg::Audacious
    package ArchPkg::Xournalpp
    package ArchPkg::Evince
    package ArchPkg::Viewnior
    package ArchPkg::LibreOffice
  end

  group('Other') do
    package ArchPkg::PythonPygments
    package ArchPkg::Gobang

    # chromedriver
  end

  group('Virtualization') do
    package ArchPkg::VirtualboxHostModulesArch
    package ArchPkg::Virtualbox
    package ArchPkg::VirtualboxGuestUtils
    package ArchPkg::Vagrant
  end
end

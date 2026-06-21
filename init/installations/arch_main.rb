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

  # TODO: Postpone
  # group('AUR helper') do
  #   package ArchPkg::Yay
  # end

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
end

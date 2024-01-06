# frozen_string_literal: true

OsxPkgs = OSX::Any

OSXMain = Packager::Installation.new do
  group('Create folders') do
    package OsxPkgs::ConfigFolder
    package OsxPkgs::ProjectsFolder
  end

  package OsxPkgs::LinkDotfiles

  group('Mac settings') do
    package OsxPkgs::SettingsColumnsBoard
    package OsxPkgs::SettingsRowsBoard
    package OsxPkgs::SettingsDockAutohide
    package OsxPkgs::RestartDock
    package OsxPkgs::SettingsDisableFinderAnimations
    package OsxPkgs::RestartFinder
  end

  package OsxPkgs::SheldonInit
  package OsxPkgs::Tpm

  group('Doom emacs') do
    package OsxPkgs::DoomEmacs
    package OsxPkgs::DoomEmacsIcon
  end

  group('Ruby toolchain') do
    package OsxPkgs::RubyRubocop
    package OsxPkgs::RubySolargraph
  end

  group('Node toolchain') do
    package OsxPkgs::JsBeautify
  end

  group('Rust & toolchain') do
    package OsxPkgs::RustLangRustup
    package OsxPkgs::RustupAddNightly
    package OsxPkgs::RustupAddClippy
    package OsxPkgs::RustupAddRustAnalyser
    package OsxPkgs::CargoAudit
    package OsxPkgs::CargoDeny
    package OsxPkgs::CargoEdit
    package OsxPkgs::CargoExpand
    package OsxPkgs::CargoTarpaulin
    package OsxPkgs::CargoUdeps
    package OsxPkgs::CargoWatch
  end

  group('Golang toolchain') do
    package OsxPkgs::Gvm
    package OsxPkgs::Go1204Gvm
  end
end

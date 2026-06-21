# frozen_string_literal: true

ArchPkg = Linux::Arch

ArchMain = Packager::Installation.new do
  group('Create folders') do
    package ArchPkg::ConfigFolder
    package ArchPkg::ConfigAutostartFolder
    package ArchPkg::ProjectsFolder
  end

  group('Build prerequisites') do
    package ArchPkg::Git
    package ArchPkg::BaseDevel
    package ArchPkg::Gdb
  end

  # TODO: Postpone
  # group('AUR helper') do
  #   package ArchPkg::Yay
  # end

  package ArchPkg::LinkDotfiles

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

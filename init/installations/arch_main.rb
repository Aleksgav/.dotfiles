# frozen_string_literal: true

ArchPkg = Linux::Arch

# Arch is installed "without packages": no pacman/AUR installs, only folder
# creation and dotfile linking. Add package definitions under
# packages/linux/arch/ and list them here to grow the install.
ArchMain = Packager::Installation.new do
  group('Create folders') do
    package ArchPkg::ConfigFolder
    package ArchPkg::ConfigAutostartFolder
    package ArchPkg::ProjectsFolder
  end

  package ArchPkg::LinkDotfiles
end

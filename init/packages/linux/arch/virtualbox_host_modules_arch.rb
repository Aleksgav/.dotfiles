# frozen_string_literal: true

module Linux
  module Arch
    VirtualboxHostModulesArch = Packager::Package::Builder.build do
      title 'Virtualbox Host Modules'
      command 'pacman -S --needed --noconfirm virtualbox-host-modules-arch'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

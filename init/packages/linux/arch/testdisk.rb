# frozen_string_literal: true

module Linux
  module Arch
    Testdisk = Packager::Package::Builder.build do
      title 'TestDisk'
      command 'pacman -S --needed --noconfirm testdisk'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

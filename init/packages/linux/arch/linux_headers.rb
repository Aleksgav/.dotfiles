# frozen_string_literal: true

module Linux
  module Arch
    LinuxHeaders = Packager::Package::Builder.build do
      title 'Linux Headers'
      command 'pacman -S --needed --noconfirm linux-headers'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

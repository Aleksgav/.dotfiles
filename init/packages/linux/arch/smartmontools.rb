# frozen_string_literal: true

module Linux
  module Arch
    Smartmontools = Packager::Package::Builder.build do
      title 'smartmontools'
      command 'pacman -S --needed --noconfirm smartmontools'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

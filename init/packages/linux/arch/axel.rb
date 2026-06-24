# frozen_string_literal: true

module Linux
  module Arch
    Axel = Packager::Package::Builder.build do
      title 'Axel'
      command 'pacman -S --needed --noconfirm axel'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

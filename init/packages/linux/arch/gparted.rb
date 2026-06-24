# frozen_string_literal: true

module Linux
  module Arch
    Gparted = Packager::Package::Builder.build do
      title 'GParted'
      command 'pacman -S --needed --noconfirm gparted'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

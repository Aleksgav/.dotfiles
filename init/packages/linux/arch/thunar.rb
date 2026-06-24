# frozen_string_literal: true

module Linux
  module Arch
    Thunar = Packager::Package::Builder.build do
      title 'Thunar'
      command 'pacman -S --needed --noconfirm thunar'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

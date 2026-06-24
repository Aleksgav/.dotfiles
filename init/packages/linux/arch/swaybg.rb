# frozen_string_literal: true

module Linux
  module Arch
    Swaybg = Packager::Package::Builder.build do
      title 'Swaybg'
      command 'pacman -S --needed --noconfirm swaybg'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

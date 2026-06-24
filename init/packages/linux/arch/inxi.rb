# frozen_string_literal: true

module Linux
  module Arch
    Inxi = Packager::Package::Builder.build do
      title 'inxi'
      command 'pacman -S --needed --noconfirm inxi'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

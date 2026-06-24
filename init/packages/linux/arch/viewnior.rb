# frozen_string_literal: true

module Linux
  module Arch
    Viewnior = Packager::Package::Builder.build do
      title 'Viewnior'
      command 'pacman -S --needed --noconfirm viewnior'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

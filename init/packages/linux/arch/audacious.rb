# frozen_string_literal: true

module Linux
  module Arch
    Audacious = Packager::Package::Builder.build do
      title 'Audacious'
      command 'pacman -S --needed --noconfirm audacious'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

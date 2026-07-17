# frozen_string_literal: true

module Linux
  module Arch
    Udiskie = Packager::Package::Builder.build do
      title 'udiskie (removable-media automount daemon)'
      command 'pacman -S --needed --noconfirm udiskie'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

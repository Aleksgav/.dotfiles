# frozen_string_literal: true

module Linux
  module Arch
    Bluez = Packager::Package::Builder.build do
      title 'BlueZ'
      command 'pacman -S --needed --noconfirm bluez'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl enable bluetooth', sudo: true
    end
  end
end

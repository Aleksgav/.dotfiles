# frozen_string_literal: true

module Linux
  module Arch
    Cups = Packager::Package::Builder.build do
      title 'CUPS'
      command 'pacman -S --needed --noconfirm cups'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl enable cups.service', sudo: true
    end
  end
end

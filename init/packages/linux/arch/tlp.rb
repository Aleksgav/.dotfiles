# frozen_string_literal: true

module Linux
  module Arch
    Tlp = Packager::Package::Builder.build do
      title 'TLP'
      command 'pacman -S --needed --noconfirm tlp'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl enable tlp', sudo: true
      # Only install on laptops
      chassis :laptop
    end
  end
end

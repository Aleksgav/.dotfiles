# frozen_string_literal: true

module Linux
  module Arch
    Certbot = Packager::Package::Builder.build do
      title 'Certbot'
      command 'pacman -S --needed --noconfirm certbot'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

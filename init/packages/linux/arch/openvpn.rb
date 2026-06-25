# frozen_string_literal: true

module Linux
  module Arch
    Openvpn = Packager::Package::Builder.build do
      title 'OpenVPN'
      command 'pacman -S --needed --noconfirm openvpn'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

# frozen_string_literal: true

module Linux
  module Arch
    NetworkmanagerOpenvpn = Packager::Package::Builder.build do
      title 'NetworkManager OpenVPN'
      command 'pacman -S --needed --noconfirm networkmanager-openvpn'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

# frozen_string_literal: true

module Linux
  module Arch
    WireguardTools = Packager::Package::Builder.build do
      title 'WireGuard tools'
      command 'pacman -S --needed --noconfirm wireguard-tools'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

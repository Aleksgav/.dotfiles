# frozen_string_literal: true

module Linux
  module Arch
    YubikeyManager = Packager::Package::Builder.build do
      title 'YubiKey Manager'
      command 'pacman -S --needed --noconfirm yubikey-manager'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

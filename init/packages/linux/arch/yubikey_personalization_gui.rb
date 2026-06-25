# frozen_string_literal: true

module Linux
  module Arch
    YubikeyPersonalizationGui = Packager::Package::Builder.build do
      title 'YubiKey Personalization GUI'
      command 'pacman -S --needed --noconfirm yubikey-personalization-gui'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

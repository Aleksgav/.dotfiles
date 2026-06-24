# frozen_string_literal: true

module Linux
  module Arch
    WpaSupplicant = Packager::Package::Builder.build do
      title 'wpa_supplicant'
      command 'pacman -S --needed --noconfirm wpa_supplicant'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

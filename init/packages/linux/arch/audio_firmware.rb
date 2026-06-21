# frozen_string_literal: true

module Linux
  module Arch
    AudioFirmware = Packager::Package::Builder.build do
      title 'Audio firmware'
      command 'pacman -S --needed --noconfirm sof-firmware alsa-firmware'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

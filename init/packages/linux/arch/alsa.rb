# frozen_string_literal: true

module Linux
  module Arch
    Alsa = Packager::Package::Builder.build do
      title 'ALSA utils'
      command 'pacman -S --needed --noconfirm alsa-utils'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

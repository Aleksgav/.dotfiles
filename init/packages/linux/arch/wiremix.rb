# frozen_string_literal: true

module Linux
  module Arch
    Wiremix = Packager::Package::Builder.build do
      title 'Wiremix'
      command 'pacman -S --needed --noconfirm wiremix'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

# frozen_string_literal: true

module Linux
  module Arch
    Wireplumber = Packager::Package::Builder.build do
      title 'WirePlumber'
      command 'pacman -S --needed --noconfirm wireplumber'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

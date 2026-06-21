# frozen_string_literal: true

module Linux
  module Arch
    Zenith = Packager::Package::Builder.build do
      title 'Zenith'
      command 'pacman -S --needed --noconfirm zenith'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

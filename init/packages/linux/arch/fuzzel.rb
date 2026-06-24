# frozen_string_literal: true

module Linux
  module Arch
    Fuzzel = Packager::Package::Builder.build do
      title 'Fuzzel'
      command 'pacman -S --needed --noconfirm fuzzel'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

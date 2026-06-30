# frozen_string_literal: true

module Linux
  module Arch
    PacmanContrib = Packager::Package::Builder.build do
      title 'pacman-contrib'
      command 'pacman -S --needed --noconfirm pacman-contrib'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

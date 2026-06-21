# frozen_string_literal: true

module Linux
  module Arch
    Syncthing = Packager::Package::Builder.build do
      title 'Syncthing'
      command 'pacman -S --needed --noconfirm syncthing'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

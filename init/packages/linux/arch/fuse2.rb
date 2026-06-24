# frozen_string_literal: true

module Linux
  module Arch
    Fuse2 = Packager::Package::Builder.build do
      title 'FUSE 2'
      command 'pacman -S --needed --noconfirm fuse2'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

# frozen_string_literal: true

module Linux
  module Arch
    Rsync = Packager::Package::Builder.build do
      title 'rsync'
      command 'pacman -S --needed --noconfirm rsync'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

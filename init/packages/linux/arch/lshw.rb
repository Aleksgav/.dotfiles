# frozen_string_literal: true

module Linux
  module Arch
    Lshw = Packager::Package::Builder.build do
      title 'lshw'
      command 'pacman -S --needed --noconfirm lshw'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

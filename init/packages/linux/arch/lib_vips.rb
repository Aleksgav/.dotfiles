# frozen_string_literal: true

module Linux
  module Arch
    LibVips = Packager::Package::Builder.build do
      title 'Vips'
      command 'pacman -S --needed --noconfirm libvips'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

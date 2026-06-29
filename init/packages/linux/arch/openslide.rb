# frozen_string_literal: true

module Linux
  module Arch
    Openslide = Packager::Package::Builder.build do
      title 'Openslide'
      command 'pacman -S --needed --noconfirm openslide'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

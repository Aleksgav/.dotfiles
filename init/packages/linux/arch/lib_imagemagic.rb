# frozen_string_literal: true

module Linux
  module Arch
    LibImagemagic = Packager::Package::Builder.build do
      title 'Imagemagic'
      command 'pacman -S --needed --noconfirm imagemagick'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

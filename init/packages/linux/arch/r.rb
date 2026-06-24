# frozen_string_literal: true

module Linux
  module Arch
    R = Packager::Package::Builder.build do
      title 'R'
      command 'pacman -S --needed --noconfirm r'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

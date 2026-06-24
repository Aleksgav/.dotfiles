# frozen_string_literal: true

module Linux
  module Arch
    Iw = Packager::Package::Builder.build do
      title 'iw'
      command 'pacman -S --needed --noconfirm iw'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

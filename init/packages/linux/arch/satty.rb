# frozen_string_literal: true

module Linux
  module Arch
    Satty = Packager::Package::Builder.build do
      title 'Satty'
      command 'pacman -S --needed --noconfirm satty'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

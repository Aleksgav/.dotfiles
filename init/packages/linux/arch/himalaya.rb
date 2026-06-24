# frozen_string_literal: true

module Linux
  module Arch
    Himalaya = Packager::Package::Builder.build do
      title 'Himalaya'
      command 'pacman -S --needed --noconfirm himalaya'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

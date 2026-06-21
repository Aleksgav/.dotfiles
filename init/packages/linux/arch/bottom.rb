# frozen_string_literal: true

module Linux
  module Arch
    Bottom = Packager::Package::Builder.build do
      title 'Bottom'
      command 'pacman -S --needed --noconfirm bottom'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

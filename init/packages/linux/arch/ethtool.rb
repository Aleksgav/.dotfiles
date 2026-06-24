# frozen_string_literal: true

module Linux
  module Arch
    Ethtool = Packager::Package::Builder.build do
      title 'ethtool'
      command 'pacman -S --needed --noconfirm ethtool'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

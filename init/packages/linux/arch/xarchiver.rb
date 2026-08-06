# frozen_string_literal: true

module Linux
  module Arch
    Xarchiver = Packager::Package::Builder.build do
      title 'Xarchiver'
      command 'pacman -S --needed --noconfirm xarchiver'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

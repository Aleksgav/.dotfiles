# frozen_string_literal: true

module Linux
  module Arch
    Superfile = Packager::Package::Builder.build do
      title 'Superfile'
      command 'pacman -S --needed --noconfirm superfile'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

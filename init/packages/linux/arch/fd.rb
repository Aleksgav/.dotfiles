# frozen_string_literal: true

module Linux
  module Arch
    Fd = Packager::Package::Builder.build do
      title 'Fd'
      command 'pacman -S --needed --noconfirm fd'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

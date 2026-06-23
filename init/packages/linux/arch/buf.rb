# frozen_string_literal: true

module Linux
  module Arch
    Buf = Packager::Package::Builder.build do
      title 'Buf'
      command 'pacman -S --needed --noconfirm buf'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

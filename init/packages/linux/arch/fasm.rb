# frozen_string_literal: true

module Linux
  module Arch
    Fasm = Packager::Package::Builder.build do
      title 'Fasm'
      command 'pacman -S --needed --noconfirm fasm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

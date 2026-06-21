# frozen_string_literal: true

module Linux
  module Arch
    Nasm = Packager::Package::Builder.build do
      title 'Nasm'
      command 'pacman -S --needed --noconfirm nasm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

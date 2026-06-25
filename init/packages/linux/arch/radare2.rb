# frozen_string_literal: true

module Linux
  module Arch
    Radare2 = Packager::Package::Builder.build do
      title 'Radare2'
      command 'pacman -S --needed --noconfirm radare2'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

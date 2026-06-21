# frozen_string_literal: true

module Linux
  module Arch
    Gdb = Packager::Package::Builder.build do
      title 'GDB'
      command 'pacman -S --needed --noconfirm gdb'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

# frozen_string_literal: true

module Linux
  module Arch
    Ghidra = Packager::Package::Builder.build do
      title 'Ghidra'
      command 'pacman -S --needed --noconfirm ghidra'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
